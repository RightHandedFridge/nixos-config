{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}: let
  cfg = osConfig.modules.de.hyprland;

  # Define zoom shell commands as strings
  zoomInCommand = ''
    hyprctl keyword cursor:zoom_factor $(awk "BEGIN {print $(hyprctl getoption cursor:zoom_factor | grep 'float:' | awk '{print $2}') + 0.5}")
  '';

  zoomOutCommand = ''
    hyprctl keyword cursor:zoom_factor $(awk "BEGIN {print $(hyprctl getoption cursor:zoom_factor | grep 'float:' | awk '{print $2}') - 0.5}")
  '';

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

      # Terminal Apps
      wl-clipboard
      swappy
      hyprshot
      pulsemixer
    ];

    home.persistence."/persist/home/${config.vars.user}" = lib.mkIf osConfig.modules.system.impermanence.enable {
      directories = [
        ".local/share/keyrings"
      ];
    };

    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        exec-once = [
          "nm-applet &"
          "blueman-tray"
          "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY"
        ];

        "monitor" = ",preferred,auto,1";
        "$mod" = "ALT";
        "$modapp" = "SUPER";
        "$menu" = "wofi --show drun";
        "$browser" = "firefox";
        "$term" = "alacritty";
        "$files" = "nautilus";

        input = {
          "kb_layout" = "gb";
        };

        bind = [
          # Programs
          "$modapp, Return, exec, $term"
          "$mod, Q, killactive"
          "$modapp, S, exec, $menu"
          "$modapp, W, exec, $browser"
          "$modapp, E, exec, $files"

          # Focus Shift
          "$mod, J, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, I, movefocus, u"
          "$mod, K, movefocus, d"

          # Move Windows
          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"
          "$mod, k, movefocus, u"
          "$mod, j, movefocus, d"

          # Switch Workspaces
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"

          # Move Windows to Workspaces
          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
          "$mod SHIFT, 6, movetoworkspace, 6"
          "$mod SHIFT, 7, movetoworkspace, 7"
          "$mod SHIFT, 8, movetoworkspace, 8"

          # Screenshots
          "$mod SHIFT, S, exec, hyprshot -m region --clipboard-only --freeze"

          # Special Keys
          # Volume
          ", XF86AudioRaiseVolume, exec, ${swayosd-client} --output-volume +5 --max-volume 100"
          ", XF86AudioLowerVolume, exec, ${swayosd-client} --output-volume -5 --max-volume 100"

          # Brightness
          ", XF86MonBrightnessUp, exec, ${swayosd-client} --brightness +5"
          ", XF86MonBrightnessDown, exec, ${swayosd-client} --brightness -5"

          # Microphone
          ", XF86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"

          # Cursor Zoom In/Out
          ''SUPER,equal, exec, hyprctl keyword cursor:zoom_factor "$(hyprctl getoption cursor:zoom_factor | grep float | awk '{print $2 + 0.5}')"''
          ''SUPER,minus, exec, hyprctl keyword cursor:zoom_factor "$(hyprctl getoption cursor:zoom_factor | grep float | awk '{print $2 - 0.5}')"''
        ];

        bindn = [
          ", Caps_Lock, exec, ${swayosd-client} --caps-lock"
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
      };
    };
  };
}
