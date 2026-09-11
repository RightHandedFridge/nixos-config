#TODO: Stop doing this and just use a lua file but I don't care for now.
{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.generators) mkLuaInline;

  # Shell-based binds need a real shell (pipes / command substitution)
  quitSamePidScript = pkgs.writeShellScript "hypr-quit-same-pid" ''
    hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill
  '';

  zoomScript = delta:
    pkgs.writeShellScript "hypr-zoom-${if delta == "0.5" then "in" else "out"}" ''
      cur="$(hyprctl getoption cursor:zoom_factor | grep float | awk '{print $2}')"
      hyprctl keyword cursor:zoom_factor "$(awk -v d=${delta} -v f="$cur" 'BEGIN { print f + d }')"
    '';
in {
  home-manager.users.${config.vars.user} = lib.mkIf config.modules.desktop.hyprland.enable {
    wayland.windowManager.hyprland = {
      configType = "lua";   # ← required for the Lua-format settings

      settings = let
        bind = {mod ? null, key ? null, dispatcher, flags ? null}:
          let
            keyArg =
              if mod != null
              then mkLuaInline ''mod .. " + ${mod}"''
              else key;
            dsp = mkLuaInline dispatcher;
          in
            {_args = [keyArg dsp] ++ lib.optional (flags != null) flags;};
      in {
          # === Lua local variables ===
          mod = {_var = "SUPER";};
          menu = {_var = "rofi -show drun";};
          browser = {_var = "firefox";};
          term = {_var = "alacritty";};
          files = {_var = "nautilus";};

          # === Monitor ===
          monitor = [
            {output = ""; mode = "highrr"; position = "auto"; scale = 1;}
          ];

          # === exec-once ===
          on = {
            _args = [
              "hyprland.start"
              (mkLuaInline ''
                function()
                    hl.exec_cmd("noctalia-shell")
                end
              '')
            ];
          };

          # === Simple config sections ===
          config = {
            input = {
              kb_layout = "gb";
            };

            general = {
              gaps_out = 2;
              gaps_in = 10;
              border_size = 2;
            };

            animations = {
              enabled = false;
            };

            misc = {
              vrr = 1;
            };
          };

          workspace_rule = [
            { workspace = "w[tv1]"; gaps_in = 0; gaps_out = 0; }
            { workspace = "f[1]";   gaps_in = 0; gaps_out = 0; }
          ];      

          window_rule = [
            { match = { float = false; workspace = "w[tv1]"; }; border_size = 0; rounding = 0; }
            { match = { float = false; workspace = "f[1]"; };   border_size = 0; rounding = 0; }
          ];

          # === Keybinds ===
          bind = [
            # Programs
            (bind {mod = "Return";  dispatcher = ''hl.dsp.exec_cmd(term)'';})
            (bind {mod = "W";       dispatcher = ''hl.dsp.exec_cmd(browser)'';})
            (bind {mod = "E";       dispatcher = ''hl.dsp.exec_cmd(files)'';})
            (bind {mod = "SHIFT + L"; dispatcher = ''hl.dsp.exec_cmd("noctalia-shell ipc call lockScreen lock")'';})
            (bind {mod = "SHIFT + N"; dispatcher = ''hl.dsp.exec_cmd("noctalia-shell ipc call notifications toggleHistory")'';})

            # Launcher
            (bind {mod = "SPACE";   dispatcher = ''hl.dsp.exec_cmd("noctalia-shell ipc call launcher toggle")'';})
            (bind {mod = "ALT + B"; dispatcher = ''hl.dsp.exec_cmd("noctalia-shell ipc call bluetooth togglePanel")'';})
            (bind {mod = "ALT + N"; dispatcher = ''hl.dsp.exec_cmd("noctalia-shell ipc call wifi togglePanel")'';})
            (bind {mod = "ALT + S"; dispatcher = ''hl.dsp.exec_cmd("noctalia-shell ipc call volume togglePanel")'';})
            (bind {mod = "ALT + P"; dispatcher = ''hl.dsp.exec_cmd("rofi -show power-menu -modi power-menu:rofi-power-menu")'';})

            # Screenshots
            (bind {mod = "SHIFT + S"; dispatcher = ''hl.dsp.exec_cmd("hyprshot -m region --clipboard-only --freeze")'';})
            (bind {mod = "SHIFT + R"; dispatcher = ''hl.dsp.exec_cmd("noctalia-shell ipc call plugin:screen-recorder toggle")'';})

            # Volume
            (bind {key = "XF86AudioRaiseVolume"; dispatcher = ''hl.dsp.exec_cmd("noctalia-shell ipc call volume increase")'';})
            (bind {key = "XF86AudioLowerVolume"; dispatcher = ''hl.dsp.exec_cmd("noctalia-shell ipc call volume decrease")'';})
            (bind {key = "XF86AudioMute";        dispatcher = ''hl.dsp.exec_cmd("noctalia-shell ipc call volume muteOutput")'';})

            # Brightness
            (bind {key = "XF86MonBrightnessUp";   dispatcher = ''hl.dsp.exec_cmd("noctalia-shell ipc call brightness increase")'';})
            (bind {key = "XF86MonBrightnessDown"; dispatcher = ''hl.dsp.exec_cmd("noctalia-shell ipc call brightness decrease")'';})

            # Microphone
            (bind {key = "XF86AudioMicMute"; dispatcher = ''hl.dsp.exec_cmd("noctalia-shell ipc call volume muteInput")'';})
            (bind {mod = "SHIFT + M";        dispatcher = ''hl.dsp.exec_cmd("noctalia-shell ipc call volume muteInput")'';})

            # Cursor zoom
            (bind {mod = "mouse_down"; dispatcher = ''hl.dsp.exec_cmd("${zoomScript "0.5"}")'';})
            (bind {mod = "mouse_up";   dispatcher = ''hl.dsp.exec_cmd("${zoomScript "-0.5"}")'';})
            (bind {mod = "SHIFT + Z";  dispatcher = ''hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor 1")'';})

            ## Windows

            # Quit
            (bind {mod = "Q"; dispatcher = ''hl.dsp.window.close()'';})
            (bind {mod = "SHIFT + Q"; dispatcher = ''hl.dsp.exec_cmd("${quitSamePidScript}")'';})

            # Focus Shift
            (bind {mod = "H"; dispatcher = ''hl.dsp.focus({ direction = "l" })'';})
            (bind {mod = "L"; dispatcher = ''hl.dsp.focus({ direction = "r" })'';})
            (bind {mod = "K"; dispatcher = ''hl.dsp.focus({ direction = "u" })'';})
            (bind {mod = "J"; dispatcher = ''hl.dsp.focus({ direction = "d" })'';})

            # Switch Workspaces
            (bind {mod = "1"; dispatcher = ''hl.dsp.focus({ workspace = "1" })'';})
            (bind {mod = "2"; dispatcher = ''hl.dsp.focus({ workspace = "2" })'';})
            (bind {mod = "3"; dispatcher = ''hl.dsp.focus({ workspace = "3" })'';})
            (bind {mod = "4"; dispatcher = ''hl.dsp.focus({ workspace = "4" })'';})
            (bind {mod = "5"; dispatcher = ''hl.dsp.focus({ workspace = "5" })'';})
            (bind {mod = "6"; dispatcher = ''hl.dsp.focus({ workspace = "6" })'';})
            (bind {mod = "7"; dispatcher = ''hl.dsp.focus({ workspace = "7" })'';})
            (bind {mod = "8"; dispatcher = ''hl.dsp.focus({ workspace = "8" })'';})
            (bind {mod = "9"; dispatcher = ''hl.dsp.focus({ workspace = "9" })'';})
            (bind {mod = "0"; dispatcher = ''hl.dsp.focus({ workspace = "10" })'';})

            # Move Windows to Workspaces
            (bind {mod = "SHIFT + 1"; dispatcher = ''hl.dsp.window.move({ workspace = "1" })'';})
            (bind {mod = "SHIFT + 2"; dispatcher = ''hl.dsp.window.move({ workspace = "2" })'';})
            (bind {mod = "SHIFT + 3"; dispatcher = ''hl.dsp.window.move({ workspace = "3" })'';})
            (bind {mod = "SHIFT + 4"; dispatcher = ''hl.dsp.window.move({ workspace = "4" })'';})
            (bind {mod = "SHIFT + 5"; dispatcher = ''hl.dsp.window.move({ workspace = "5" })'';})
            (bind {mod = "SHIFT + 6"; dispatcher = ''hl.dsp.window.move({ workspace = "6" })'';})
            (bind {mod = "SHIFT + 7"; dispatcher = ''hl.dsp.window.move({ workspace = "7" })'';})
            (bind {mod = "SHIFT + 8"; dispatcher = ''hl.dsp.window.move({ workspace = "8" })'';})
            (bind {mod = "SHIFT + 9"; dispatcher = ''hl.dsp.window.move({ workspace = "9" })'';})
            (bind {mod = "SHIFT + 0"; dispatcher = ''hl.dsp.window.move({ workspace = "10" })'';})

            # Window Attributes
            (bind {mod = "F"; dispatcher = ''hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" })'';})
            (bind {mod = "T"; dispatcher = ''hl.dsp.window.float({ action = "toggle" })'';})
            (bind {mod = "SHIFT + T"; dispatcher = ''hl.dsp.exec_cmd("hyprctl dispatch workspaceopt allfloat")'';})
            (bind {mod = "U"; dispatcher = ''hl.dsp.layout("togglesplit")'';})

            # Resize active window with arrow keys
            (bind {mod = "SHIFT + h"; dispatcher = ''hl.dsp.exec_cmd("hyprctl dispatch resizeactive -100 0")''; flags = {repeating = true;};})
            (bind {mod = "SHIFT + l"; dispatcher = ''hl.dsp.exec_cmd("hyprctl dispatch resizeactive 100 0")''; flags = {repeating = true;};})
            (bind {mod = "SHIFT + k"; dispatcher = ''hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 -100")''; flags = {repeating = true;};})
            (bind {mod = "SHIFT + j"; dispatcher = ''hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 100")''; flags = {repeating = true;};})

            # Splits
            (bind {mod = "I"; dispatcher = ''hl.dsp.layout("swapsplit")'';})

            (bind {mod = "ALT + h"; dispatcher = ''hl.dsp.window.move({ direction = "l", group_aware = false })'';})
            (bind {mod = "ALT + l"; dispatcher = ''hl.dsp.window.move({ direction = "r", group_aware = false })'';})
            (bind {mod = "ALT + k"; dispatcher = ''hl.dsp.window.move({ direction = "u", group_aware = false })'';})
            (bind {mod = "ALT + j"; dispatcher = ''hl.dsp.window.move({ direction = "d", group_aware = false })'';})

            # Global Hotkeys
            (bind {key = "F8"; dispatcher = ''hl.dsp.exec_cmd("hyprctl dispatch pass class:^(com\\.obsproject\\.Studio)$")'';})

            (bind {key = "ALT + Tab"; dispatcher = ''hl.dsp.exec_cmd("hyprctl dispatch cyclenext")''; flags = {repeating = true;};})
            (bind {key = "ALT + Tab"; dispatcher = ''hl.dsp.exec_cmd("hyprctl dispatch bringactivetotop")'';})

            (bind {mod = "mouse:272"; dispatcher = ''hl.dsp.window.drag()'';   flags = {mouse = true;};})
            (bind {mod = "mouse:273"; dispatcher = ''hl.dsp.window.resize()''; flags = {mouse = true;};})
          ];
        };

        extraConfig = "";
      };
    };
}
