{
  pkgs,
  config,
  lib,
  ...
}:
# Define your choices once at the top so you don't have to hunt them down later
let
  themeName = "WhiteSur-Dark";
  themePkg = pkgs.whitesur-gtk-theme;

  cursorName = "WhiteSur-cursors";
  cursorPkg = pkgs.whitesur-cursors;
in
{
  programs.dconf.enable = true;

  home-manager.users.${config.vars.user} = lib.mkIf config.modules.desktop.framework.stylix.enable {
    home = {
      packages = with pkgs; [ dconf-editor ];

      sessionVariables = {
        XCURSOR_PATH = "${cursorPkg}/share/icons";
        XCURSOR_SIZE = 24;
        XCURSOR_THEME = cursorName;
        GTK_THEME = themeName;
      };
    };

    gtk = {
      enable = true;
      theme = {
        name = themeName;
        package = themePkg;
      };
      cursorTheme = {
        name = cursorName;
        package = cursorPkg;
        size = 24;
      };

      gtk4 = {
        theme = {
          name = themeName;
          package = themePkg;
        };
        extraConfig = {
          "gtk-application-prefer-dark-theme" = true;
        };
      };
      
      gtk3 = {
        extraConfig = {
          "gtk-application-prefer-dark-theme" = true;
        };
      };
    };

    xdg.configFile = {
      "gtk-4.0/gtk.css".source = "${themePkg}/share/themes/${themeName}/gtk-4.0/gtk.css";
      "gtk-4.0/gtk-dark.css".source = "${themePkg}/share/themes/${themeName}/gtk-4.0/gtk-dark.css";
      "gtk-4.0/assets".source = "${themePkg}/share/themes/${themeName}/gtk-4.0/assets";
    };
  };
}