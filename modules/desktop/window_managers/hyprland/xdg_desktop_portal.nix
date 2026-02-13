{ lib, pkgs, config, ... }:{
  config = lib.mkIf config.modules.desktop.hyprland.enable {
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
      config.common.default = [ "gtk" ];
      config.hyprland.default = ["hyprland" "gtk"];
    };
  };
}