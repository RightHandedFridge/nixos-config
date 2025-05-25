{
  config,
  pkgs,
  lib,
  osConfig,
  ...
}: {

  imports = [
    ../features/shortcuts.nix
    ../features/display.nix
    ../features/powerdevil.nix
  ];
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
      ".config/plasmanotifyrc" = {
        force = true;
        text = ''
          [Notifications]
          PopupPosition=TopRight
        '';
      };
    };

    home.persistence."/persist/home/${config.vars.user}" = lib.mkIf osConfig.modules.system.impermanence.enable {
      directories = [
        ".local/share/kwalletd"
      ];
    };
  };
}
