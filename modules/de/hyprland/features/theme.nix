{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.modules.de.hyprland.enable {
    home-manager.users.${config.vars.user} = {
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

      xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=WhiteSurDark
      '';

      xdg.configFile."qt5ct/qt5ct.conf".text = ''
        [Appearance]
        color_scheme_path=/home/rhf/.config/qt5ct/style-colors.conf
        custom_palette=true
        icon_theme=WhiteSur-dark
        standard_dialogs=xdgdesktopportal
        style=kvantum

        [Fonts]
        fixed="Inter,10,-1,5,50,0,0,0,0,0"
        general="Inter,10,-1,5,50,0,0,0,0,0"

        [Interface]
        activate_item_on_single_click=1
        buttonbox_layout=3
        cursor_flash_time=1000
        dialog_buttons_have_icons=1
        double_click_interval=400
        gui_effects=@Invalid()
        keyboard_scheme=2
        menus_have_icons=true
        show_shortcuts_in_context_menus=true
        stylesheets=@Invalid()
        toolbutton_style=4
        underline_shortcut=1
        wheel_scroll_lines=3
      '';

      home.packages = with pkgs; [
        whitesur-kde
      ];
    };

    qt = {
      enable = true;
      style = "kvantum";
      platformTheme = "gtk2";
    };
  };
}
