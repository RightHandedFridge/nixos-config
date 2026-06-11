{
  config,
  lib,
  pkgs,
  ...
}: {
  home-manager.users.${config.vars.user} = lib.mkIf config.modules.desktop.framework.stylix.enable {
    stylix = {
      enable = true;
      autoEnable = false;

      base16Scheme = "${pkgs.base16-schemes}/share/themes/hardcore.yaml";
      
      cursor = {
        size = 24;
        package = pkgs.whitesur-cursors;
        name = "WhiteSur-cursors";
      };

      polarity = "dark";

      fonts = {
        serif = {
          package = pkgs.inter;
          name = "Inter";
        };

        sansSerif = {
          package = pkgs.inter;
          name = "Inter";
        };

        monospace = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans Mono";
        };

        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };

        sizes = {
          terminal = 12;
          applications = 12;
          desktop = 10;
          popups = 10;
        };
      };
      icons = {
        enable = true;
        package = pkgs.whitesur-icon-theme;
        dark = "WhiteSur-dark";
        light = "WhiteSur-light";
      };
    };
  };
}
