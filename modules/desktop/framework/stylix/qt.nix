{
  lib,
  pkgs,
  config,
  ...
}:
{
  home-manager.users.${config.vars.user} = {
    home = {
      packages = with pkgs; [
        qt6Packages.qt6ct 
        libsForQt5.qt5ct
      ];
      
      sessionVariables = {
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_STYLE_OVERRIDE = "kvantum"; 
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "gtk3";
      style.name = "kvantum";
    };

    xdg.configFile = {
      # Link the parent folder 'WhiteSur' which houses both variants
      "Kvantum/WhiteSur".source = "${pkgs.whitesur-kde}/share/Kvantum/WhiteSur";
      
      # Tell Kvantum to target the 'WhiteSurDark' configuration files inside that folder
      "Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=WhiteSurDark
      '';
    };
  };
}