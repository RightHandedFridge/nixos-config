{ lib, osConfig, ... }:{
  services.displayManager.ly = lib.mkIf osConfig.modules.de.hyprland.enable {
    enable = true;
    x11Support = false;
  };
}