{ pkgs, lib, osConfig, ... }: {
  config = lib.mkIf osConfig.modules.de.hyprland.enable {

    # GTK settings for WhiteSur-Dark
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

    # Enable Qt applications with styling
    qt = {
      enable = true;

      style = {
        name = "kvantum";
        package = with pkgs; [
          qt6Packages.qtstyleplugin-kvantum
        ];
      };
    };

    # Ensure we install necessary packages, including Kvantum and the WhiteSur theme
    home.packages = with pkgs; [
      kdePackages.qtstyleplugin-kvantum
      whitesur-kde
    ];

    # Apply Kvantum config to select the WhiteSur-dark theme
    xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=WhiteSurDark
    '';

    # Set session variables to use Kvantum for Qt apps
    home.sessionVariables = {
      QT_STYLE_OVERRIDE = "kvantum"; # Forces Qt to use Kvantum styling
      QT_QPA_PLATFORMTHEME = "qt5ct"; # Ensures Qt integrates well with your desktop environment
    };

  };
}
