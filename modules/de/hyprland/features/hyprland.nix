{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}: let
  cfg = osConfig.modules.de.hyprland;
  swayosd-client = "${pkgs.swayosd}/bin/swayosd-client";
in {
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # Make sure you have base-packages imported!

      # GUI Apps
      nautilus
      eog
      file-roller
      vlc
      blueman
      pavucontrol

      # Terminal Apps
      wl-clipboard
      swappy
      hyprshot
      gpu-screen-recorder
    ];

    home.persistence."/persist/home/${config.vars.user}" = lib.mkIf osConfig.modules.system.impermanence.enable {
      directories = [
        ".local/share/keyrings"
      ];
    };

    wayland.windowManager.hyprland = {
      enable = true;
      systemd = {
        enable = true;
        variables = ["--all"];
      };

      settings = {
        exec-once = [
          "noctalia-shell"
        ];
        "monitor" = ",highrr,auto,1";
        "$mod" = "SUPER";
        "$menu" = "rofi -show drun";
        "$browser" = "firefox";
        "$term" = "alacritty";
        "$files" = "nautilus";

        input = {
          "kb_layout" = "gb";
        };

        bind = [
          # Programs
          "$mod, Return, exec, $term"
          "$mod, W, exec, $browser"
          "$mod, E, exec, $files"
          "$mod SHIFT, L, exec, noctalia-shell ipc call lockScreen lock"
          "$mod SHIFT, N, exec, noctalia-shell ipc call notifications toggleHistory"

          # Launcher
          "$mod, SPACE, exec, noctalia-shell ipc call launcher toggle"
          "$mod ALT, B, exec, noctalia-shell ipc call bluetooth togglePanel"
          "$mod ALT, N, exec, noctalia-shell ipc call wifi togglePanel"
          "$mod ALT, S, exec, noctalia-shell ipc call volume togglePanel"
          "$mod ALT, P, exec, rofi -show power-menu -modi power-menu:rofi-power-menu"

          # Screenshots
          "$mod SHIFT, S, exec, hyprshot -m region --clipboard-only --freeze"
          "$mod SHIFT, R, exec, gpu-screen-recorder -w portal -o /tmp/clip.mp4 && wl-copy < /tmp/clip.mp4"

          # Special Keys
          # Volume
          ", XF86AudioRaiseVolume, exec, noctalia-shell ipc call volume increase"
          ", XF86AudioLowerVolume, exec, noctalia-shell ipc call volume decrease"
          ", XF86AudioMute, exec, noctalia-shell ipc call volume muteOutput"

          # Brightness
          ", XF86MonBrightnessUp, exec, noctalia-shell ipc call brightness increase"
          ", XF86MonBrightnessDown, exec, noctalia-shell ipc call brightness decrease"

          # Microphone
          ", XF86AudioMicMute, exec, noctalia-shell ipc call volume muteInput"

          # Cursor Zoom In/Out
          ''$mod, mouse_down, exec, hyprctl keyword cursor:zoom_factor "$(hyprctl getoption cursor:zoom_factor | grep float | awk '{print $2 + 0.5}')"''
          ''$mod, mouse_up, exec, hyprctl keyword cursor:zoom_factor "$(hyprctl getoption cursor:zoom_factor | grep float | awk '{print $2 - 0.5}')"''
          ''$mod SHIFT, Z, exec, hyprctl keyword cursor:zoom_factor 1'' #Reset Zoom

          ## Windows

          # Quit
          "$mod, Q, killactive" # Quit Focus
          "$mod SHIFT, Q, exec, hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill" # Quit all instances

          # Focus Shift
          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, K, movefocus, u"
          "$mod, J, movefocus, d"

          # Switch Workspaces
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod, 0, workspace, 10"

          # Move Windows to Workspaces
          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
          "$mod SHIFT, 6, movetoworkspace, 6"
          "$mod SHIFT, 7, movetoworkspace, 7"
          "$mod SHIFT, 8, movetoworkspace, 8"
          "$mod SHIFT, 9, movetoworkspace, 9"
          "$mod SHIFT, 0, movetoworkspace, 10"

          # Window Attributes
          "$mod, F, fullscreen, 0" # Set Window to true fullscreen (above everything)
          "$mod, T, togglefloating"
          "$mod SHIFT, T, workspaceopt, allfloat"
          "$mod, U, togglesplit" # Switch between types of split (horizontal/vertical)

          # Resize active window with arrow keys
          "$mod SHIFT, h, resizeactive, -100 0"
          "$mod SHIFT, l, resizeactive, 100 0"
          "$mod SHIFT, k, resizeactive, 0 -100"
          "$mod SHIFT, j, resizeactive, 0 100"

          # Splits
          "$mod, I, swapsplit" # Swap window positions easy peasy

          "$mod ALT, h, swapwindow, l"
          "$mod ALT, l, swapwindow, r"
          "$mod ALT, k, swapwindow, u"
          "$mod ALT, j, swapwindow, d"
        ];

        bindm = [
          "$mod, mouse:272, movewindow" # Move active window with LMB + Drag
          "$mod, mouse:273, resizewindow" # Resize active window with RMB + Drag
        ];

        binde = [
          "ALT,Tab,cyclenext" # Cycle between windows
          "ALT,Tab,bringactivetotop" # Bring active window to the top after we cycled to it
        ];

        general = {
          gaps_out = 2;
          gaps_in = 10;
          border_size = 2;
        };

        workspace = [
          "w[tv1], gapsout:0, gapsin:0"
          "f[1], gapsout:0, gapsin:0"
        ];

        windowrule = [
          "bordersize 0, floating:0, onworkspace:w[tv1]"
          "rounding 0, floating:0, onworkspace:w[tv1]"
          "bordersize 0, floating:0, onworkspace:f[1]"
          "rounding 0, floating:0, onworkspace:f[1]"
        ];

        animations = {
          enabled = 0;
        };

        misc = {
          vrr = 1;
        };
      };
    };
  };
}
