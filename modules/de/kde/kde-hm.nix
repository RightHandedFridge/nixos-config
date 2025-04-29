{
  config,
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.modules.de.kde.enable {
    programs.plasma = {
      enable = true;
      overrideConfig = true;
      session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";

      powerdevil = {
        batteryLevels.criticalAction = "hibernate";
        AC = {
          autoSuspend.action = "nothing";
          dimDisplay.enable = false;
          powerProfile = "performance";
          whenLaptopLidClosed = "sleep";
        };
        battery = {
          autoSuspend.action = "sleep";
          autoSuspend.idleTimeout = 600;
          dimDisplay.enable = true;
          dimDisplay.idleTimeout = 300;
          powerProfile = "balanced";
          whenLaptopLidClosed = "sleep";
        };
      };

      workspace = {
        lookAndFeel = "com.github.vinceliuice.WhiteSur-dark";
        theme = "WhiteSur-dark";
        iconTheme = "WhiteSur-dark";
        cursor.theme = "WhiteSur-cursors";
      };

      panels = [
        #System Tray + Clock Panel
        {
          alignment = "right";
          floating = true;
          height = 44;
          hiding = "autohide";
          lengthMode = "fit";
          location = "top";
          widgets = [
            "org.kde.plasma.systemtray"
            "org.kde.plasma.digitalclock"
          ];
        }
      ];

      kwin = {
        virtualDesktops.names = [
          "Browser"
          "Left"
          "Right"
          "Comms"
          "Music"
        ];
        virtualDesktops.rows = 1;
        titlebarButtons.right = [
          "minimize"
          "maximize"
          "close"
        ];
      };

      hotkeys.commands = {
        "launch-alacritty" = {
          name = "Launch alacritty";
          key = "Meta+Return";
          command = "alacritty";
        };

        "launch-krunner" = {
          name = "Launch Krunner";
          key = "Meta+S";
          command = "krunner";
        };
      };
      shortcuts = {
        kwin = {
          "Window Maximize" = "Alt+Shift+W";
          "Window Close" = "Alt+Q";
          "Overview" = "Meta";
          "Kill Window" = "Alt+Shift+Q";
          "Switch to Desktop 1" = "Alt+1";
          "Switch to Desktop 2" = "Alt+2";
          "Switch to Desktop 3" = "Alt+3";
          "Switch to Desktop 4" = "Alt+4";
          "Switch to Desktop 5" = "Alt+5";
          "Window to Desktop 1" = "Alt+!";
          "Window to Desktop 2" = "Alt+\"";
          "Window to Desktop 3" = "Alt+£";
          "Window to Desktop 4" = "Alt+%";
          "Window to Desktop 5" = "Alt+^";
        };
        krunner = {
          activateWhenTypingOnDesktop = "true";
          historyBehaviour = "enableSuggestions";
          position = "top";
        };
      };

      spectacle.shortcuts.captureRectangularRegion = "Meta+Shift+S";

      window-rules = [
        {
          description = "All windows must be maximized";
          match = {
            window-class = {
              type = "regex";
              value = ".*";
            };
            window-types = ["normal"];
          };
          apply = {
            maximizehoriz = true;
            maximizevert = true;
          };
        }
      ];

      fonts = {
        general = {
          family = "Inter";
          pointSize = 10;
        };

        small = {
          family = "Inter";
          pointSize = 8;
        };

        toolbar = {
          family = "Inter";
          pointSize = 10;
        };

        menu = {
          family = "Inter";
          pointSize = 10;
        };

        windowTitle = {
          family = "Inter";
          pointSize = 10;
        };
      };
    };

    gtk = {
      enable = true;
      theme = {
        name = "WhiteSur-Dark";
        package = pkgs.whitesur-gtk-theme;
      };

      iconTheme = {
        name = "WhiteSur-dark";
        package = pkgs.whitesur-icon-theme;
      };
    };
    home.file = {
      ".config/kwinoutputconfig.json".source = ../../../dotfiles/kde/${config.vars.host}-display.json;
    };

    home.persistence."/persist/home/${config.vars.user}" = lib.mkIf config.modules.impermanence.enable {
      directories = [
        ".local/share/kwalletd"
      ];
    };
  };
}
