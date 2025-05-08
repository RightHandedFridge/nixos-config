{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.modules.de.hyprland.enable {
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

      font = {
        package = pkgs.inter;
        name = "Inter";
        size = 10;
      };

      cursorTheme = {
        name = "WhiteSur-cursors";
        package = pkgs.whitesur-cursors;
        size = 16;
      };
    };

    qt = {
      enable = true;
      style = {
        name = "kvantum";
        package = pkgs.whitesur-kde;
      };
    };

    home.file.".config/Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=WhiteSurDark
    '';
  };
}
