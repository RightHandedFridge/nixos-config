{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}: let
  cfg = osConfig.modules.de.hyprland;
in {
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # Make sure you have base-packages imported!

      #GUI Apps
      nautilus
      gnome-disk-utility
      file-roller
      vlc

      #Terminal Apps
      pavucontrol
      grim
      slurp
      wl-clipboard
      swappy
    ];

    home.persistence."/persist/home/${config.vars.user}" = config.modules.impermanence.enable {
      directories = [
        ".local/share/keyrings"
      ];
    };

    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        exec-once = [
          "nm-applet &"
          "blueman-applet"
        ];

        "monitor" = ",preferred,auto,1";
        "$mod" = "ALT";
        "$modapp" = "SUPER";
        "$menu" = "wofi --show drun";
        "$browser" = "librewolf";
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

          # Switch Workspaces
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"

          # Move Windows Workspaces
          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
          "$mod SHIFT, 6, movetoworkspace, 6"
          "$mod SHIFT, 7, movetoworkspace, 7"
          "$mod SHIFT, 8, movetoworkspace, 8"

          #Screenshots
          "$mod SHIFT, S, exec, grim -g \"$(slurp -w 0)\" - | swappy -f -"

          #Recording

          # Special Keys
          # Volume
          ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
          ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
          ", XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"

          #Brightness
          ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
          ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"

          #Microphone
          ", XF86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"
        ];

        general = {
          gaps_out = 2;
          gaps_in = 10;
          border_size = 2;
        };
      };
    };

    programs.wofi = lib.mkForce {
      enable = true;
      settings = {
        allow-images = true;
        show_icons = true;
      };
      style = ''
        window {
          background-color: rgba(36, 36, 36, 0.9);
          border-radius: 8px;
          padding: 10px;
        }

        #input {
          font-family: "Montserrat";
          font-size: 20px;
          color: #DEDEDE;
          background-color: rgba(126, 126, 126, 0.5);
          padding: 10px;
          border-radius: 4px;
        }

        #inner-box {
          background-color: transparent;
          margin: 10px;
        }

        #outer-box {
          background-color: transparent;
          padding: 10px;
        }

        #scroll {
          background-color: transparent;
        }

        #entry {
          font-family: "Montserrat";
          font-size: 14px;
          color: #DEDEDE;
          padding: 10px;
          border-radius: 4px;
        }

        #entry:selected {
          background-color: rgba(8, 96, 242, 0.9);
          color: #FFFFFF;
        }

        #text {
          color: inherit;
        }

        #img {
          margin-right: 8px;
        }
      '';
    };

    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = {
        # Waybar configuration
        waybar = {
          height = 30;
          spacing = 4;
          modules-left = [
            "hyprland/workspaces"
          ];

          modules-center = [
            "hyprland/window"
          ];

          modules-right = [
            "tray"
            "idle_inhibitor"
            "pulseaudio"
            "backlight"
            "battery"
            "clock"
          ];

          "keyboard-state" = {
            numlock = true;
            capslock = true;
            format = "{name} {icon}";
            format-icons = {
              locked = "";
              unlocked = "";
            };
          };

          "hyprland/mode" = {
            format = "<span style=\"italic\">{}</span>";
          };

          "hyprland/scratchpad" = {
            format = "{icon} {count}";
            show-empty = false;
            format-icons = ["" ""];
            tooltip = true;
            tooltip-format = "{app}: {title}";
          };

          "mpd" = {
            format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
            format-disconnected = "Disconnected ";
            format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
            unknown-tag = "N/A";
            interval = 5;
            consume-icons = {
              on = " ";
            };
            random-icons = {
              off = "<span color=\"#f53c3c\"></span> ";
              on = " ";
            };
            repeat-icons = {
              on = " ";
            };
            single-icons = {
              on = "1 ";
            };
            state-icons = {
              paused = "";
              playing = "";
            };
            tooltip-format = "MPD (connected)";
            tooltip-format-disconnected = "MPD (disconnected)";
          };

          "idle_inhibitor" = {
            format = "{icon}";
            format-icons = {
              activated = "";
              deactivated = "";
            };
          };

          "tray" = {
            spacing = 10;
          };

          "clock" = {
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format-alt = "{:%Y-%m-%d}";
          };

          "cpu" = {
            format = "{usage}% ";
            tooltip = false;
          };

          "memory" = {
            format = "{}% ";
          };

          "temperature" = {
            critical-threshold = 80;
            format = "{temperatureC}°C {icon}";
            format-icons = ["" "" ""];
          };

          "backlight" = {
            format = "{percent}% {icon}";
            format-icons = ["" "" "" "" "" "" "" "" ""];
          };

          "battery" = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{capacity}% {icon}";
            format-full = "{capacity}% {icon}";
            format-charging = "{capacity}% ";
            format-plugged = "{capacity}% ";
            format-alt = "{time} {icon}";
            format-icons = ["" "" "" "" ""];
          };

          "battery#bat2" = {
            bat = "BAT2";
          };

          "power-profiles-daemon" = {
            format = "{icon}";
            tooltip-format = "Power profile: {profile}\nDriver: {driver}";
            tooltip = true;
            format-icons = {
              default = "";
              performance = "";
              balanced = "";
              power-saver = "";
            };
          };

          "network" = {
            format-wifi = "{essid} ({signalStrength}%) ";
            format-ethernet = "{ipaddr}/{cidr} ";
            tooltip-format = "{ifname} via {gwaddr} ";
            format-linked = "{ifname} (No IP) ";
            format-disconnected = "Disconnected ⚠";
            on-click = "nm-connection-editor";
          };

          "pulseaudio" = {
            format = "{volume}% {icon} {format_source}";
            format-bluetooth = "{volume}% {icon} {format_source}";
            format-bluetooth-muted = " {icon} {format_source}";
            format-muted = " {format_source}";
            format-source = "{volume}% ";
            format-source-muted = "";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = ["" "" ""];
            };
            on-click = "pavucontrol";
            ignored-sinks = ["Easy Effects Sink"];
          };

          "custom/media" = {
            format = "{icon} {text}";
            return-type = "json";
            max-length = 40;
            format-icons = {
              spotify = "";
              default = "🎜";
            };
            escape = true;
            exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null";
          };

          "custom/power" = {
            format = "⏻ ";
            tooltip = false;
            menu = "on-click";
            menu-file = "$HOME/.config/waybar/power_menu.xml";
            menu-actions = {
              shutdown = "shutdown";
              reboot = "reboot";
              suspend = "systemctl suspend";
              hibernate = "systemctl hibernate";
            };

            "bluetooth" = {
              format = " {status}";
              format-disabled = "";
              format-connected = " {num_connections} connected";
              tooltip-format = "{controller_alias}\t{controller_address}";
              tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
              tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
              on-click = "blueman-manager";
            };
          };
        };
      };

      style = ''
        * {
          font-family: "Inter", "Font Awesome 6 Free", serif;
        }
      '';
    };

    services.mako = {
      enable = true;
      icons = true;
    };
  };
}
