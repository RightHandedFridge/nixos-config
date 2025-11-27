{
  lib,
  pkgs,
  inputs,
  ...
}: {
  stylix = {
    enable = true;
    autoEnable = true;
    cursor = {
      size = 24;
      package = pkgs.whitesur-cursors;
      name = "WhiteSur-cursors";
    };

    base16Scheme = "${pkgs.base16-schemes}/share/themes/bright.yaml";

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

    targets = {
      qt = {
        platform = "qtct";
      };

      vscode = {
        profileNames = ["default"];
      };

      librewolf = {
        profileNames = ["rhf"];
      };

      firefox = {
        profileNames = ["rhf"];
      };

      rofi = {
        enable = false;
      };
    };

    iconTheme = {
      enable = true;
      package = pkgs.whitesur-icon-theme;
      dark = "WhiteSur-dark";
      light = "WhiteSur-light";
    };
  };

  #Use my decorations damn you!
  home.sessionVariables = {
    GTK_USE_PORTAL = "1";
    GTK_CSD = "0";
  };
}
