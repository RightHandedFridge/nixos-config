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
        mainBar = {
          layer = "top";
          position = "bottom";
          height = 30;
          spacing = 4;

          modules-left = ["hyprland/workspaces"];
          modules-center = ["hyprland/window"];
          modules-right = ["tray" "pulseaudio" "network" "bluetooth" "battery" "clock"];

          "hyprland/workspaces" = {
            disable-scroll = false;
            all-outputs = true;
            format = "{icon}";
            on-click = "activate";
          };

          "custom/lock" = {
            format = "<span color='#dcdfe1'>    </span>";
            on-click = "hyprlock";
            tooltip = true;
          };

          "custom/power" = {
            format = "<span color='#FF4040'>    </span>";
            on-click = "wlogout -b 5 -r 1";
            tooltip = true;
          };

          network = {
            format-wifi = "<span color='#FFFFFF'> 󰖩  </span>{essid} ";
            format-ethernet = "<span color='#FFFFFF'>   </span>Wired ";
            tooltip-format = "<span color='#FF1493'> 󰅧  </span>{bandwidthUpBytes}  <span color='#00BFFF'> 󰅢 </span>{bandwidthDownBytes}";
            format-linked = "<span color='#FF0000'> 󱘖  </span>{ifname} (No IP) ";
            format-disconnected = "<span color='#FF0000'>   </span>Disconnected ";
            format-alt = "<span color='#00FFFF'> 󰖩  </span>{signalStrength}% ";
            interval = 1;
          };

          battery = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "<span color='#28CD41'> {icon}  </span>{capacity}% ";
            format-charging = " 󱐋 {capacity}% ";
            interval = 1;
            format-icons = ["" "" "" "" ""];
            tooltip = true;
          };

          pulseaudio = {
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
            on-click-right = "pavucontrol";
            on-click = "pactl -- set-sink-mute 0 toggle";
            tooltip = true;
          };

          clock = {
            interval = 1;
            timezone = "Europe/Rome";
            format = "{:%H:%M}";
            tooltip = true;
            tooltip-format = "{:L%A %d/%m/%Y}";
          };

          tray = {
            icon-size = 17;
            spacing = 6;
          };
        };
      };

      style = ''
        /* Global font and size */
        * {
          font-family: "Inter", "Font Awesome 6 Free";
          font-size: 14px;
          color: #ffffff;
        }

        /* Waybar window styling */
        window#waybar {
          background-color: rgba(0, 0, 0, 1);
          transition: background-color 0.5s;
        }

        /* Module spacing */
        .modules-left,
        .modules-center,
        .modules-right {
          padding: 0 4px;
        }

        /* Specific modules adjustments */
        #tray {
          margin: 5px 0;
        }

        #custom-lock,
        #custom-bluetooth-status,
        #custom-fast-control-menu {
          padding-left: 25px;
        }

        #custom-lock,
        #custom-bluetooth-status {
          padding-right: 8px;
        }

        /* Hidden Waybar fades */
        window#waybar.hidden {
          opacity: 0.1;
        }

        /* Battery warnings */
        #battery.warning { color: #ecd3a0; }
        #battery.critical:not(.charging) { color: #fb958b; }
      '';
    };
  };
}
