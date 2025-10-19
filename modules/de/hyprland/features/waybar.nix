{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.modules.de.hyprland.enable {
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

          "hyprland/window" = {
            format = "{}";
            max-length = 40;
            separate-outputs = true;
            offscreen-css = true;
            offscreen-css-text = "(inactive)";
          };

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
            on-click = "alacritty -e pulsemixer";
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
          font-family:
          "Inter",
          "Font Awesome 6 Free";
          font-size: 14px;
        }

        window#waybar {
          background-color: rgba(0, 0, 0, 0.6);
          color: #ffffff;
          transition-property: background-color;
          transition-duration: 0.5s;
        }

        /* This section can be use if you want to separate waybar modules */
        .modules-left,
        .modules-center,
        .modules-right {
          /* border: 0.5px solid @overlay0; */
          padding-right: 4px;
          padding-left: 4px;
        }

        /* .modules-left, */
        /* .modules-right { */
        /*   padding-top: 2px; */
        /*   padding-bottom: 2px; */
        /*   padding-right: 4px; */
        /*   padding-left: 4px; */
        /* } */
        #backlight,
        #backlight-slider,
        #battery,
        #bluetooth,
        #clock,
        #cpu,
        #disk,
        #idle_inhibitor,
        #keyboard-state,
        #memory,
        #mode,
        #mpris,
        #network,
        #pulseaudio,
        #pulseaudio-slider,
        #taskbar button,
        #taskbar,
        #temperature,
        #tray,
        #window,
        #wireplumber,
        #workspaces,
        #custom-backlight,
        #custom-cycle_wall,
        #custom-keybinds,
        #custom-keyboard,
        #custom-light_dark,
        #custom-lock,
        #custom-menu,
        #custom-power_vertical,
        #custom-power,
        #custom-swaync,
        #custom-updater,
        #custom-weather,
        #custom-weather.clearNight,
        #custom-weather.cloudyFoggyDay,
        #custom-weather.cloudyFoggyNight,
        #custom-weather.default,
        #custom-weather.rainyDay,
        #custom-weather.rainyNight,
        #custom-weather.severe,
        #custom-weather.showyIcyDay,
        #custom-weather.snowyIcyNight,
        #custom-weather.sunnyDay {
          padding-right: 6px;
          padding-left: 6px;
        }

        window#waybar.hidden {
          opacity: 0.1;
        }

        #window {
          color: #ffffff;
          font-weight: bold;
        }

        #clock,
        #custom-media,
        #tray,
        #mode,
        #custom-lock,
        #workspaces,
        #idle_inhibitor,
        #custom-power-menu,
        #battery,
        #pulseaudio,
        #network,
        #language,
        #custom-bluetooth-status {
          color: #ffffff;
          /* margin-top: 2px; */
          /* margin-bottom: 2px; */
          /* padding-left: 20px; */
        }

        #custom-bluetooth-status {
          padding-right: 8px;
        }

        #custom-notify {
          padding-left: 25px;
        }

        #custom-lock {
          padding-left: 25px;
          padding-right: 8px;
        }

        #custom-fast-control-menu {
          padding-left: 25px;
        }
        #tray {
          color: #ffffff;
          /* padding-right: 8px; */
          margin-top: 5px;
          margin-bottom: 5px;
        }

        #tray > .passive {
          -gtk-icon-effect: dim;
        }

        #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background-color: #eb4d4b;
        }

        #custom-bluetooth-status {
          padding-top: 4px;
          font: 0.9em sans-serif;
        }

        #custom-fast-control-menu {
          font-size: 18px;
          padding-top: 4px;
        }

        #pulseaudio,
        #pulseaudio.muted {
        }

        #network.disconnected {
          color: #fff;
        }

        #battery {
          /* color: #8fbcbb; */
        }

        #battery.critical,
        #battery.warning,
        #battery.full,
        #battery.plugged {
          /* color: #8fbcbb; */
        }

        @keyframes blink {
          to {
            background-color: rgba(30, 34, 42, 0.5);
            color: #abb2bf;
          }
        }

        #battery.warning {
          color: #ecd3a0;
        }

        #battery.critical:not(.charging) {
          color: #fb958b;
        }

      '';
    };
  };
}
