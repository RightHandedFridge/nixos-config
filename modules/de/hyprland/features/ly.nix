{ lib, config, ... }:{
  services.displayManager.ly = lib.mkIf config.modules.de.hyprland.enable {
    enable = true;
  };
}