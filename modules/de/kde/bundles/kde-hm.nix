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
    ../features/panels.nix
  ];
  config = lib.mkIf osConfig.modules.de.kde.enable {
    programs.plasma = {
      enable = true;
      overrideConfig = true;
      session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";

      workspace = {
        lookAndFeel = "com.github.vinceliuice.WhiteSur-dark";
        theme = "WhiteSur-dark";
        iconTheme = "WhiteSur-dark";
        cursor.theme = "WhiteSur-cursors";
      };

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
