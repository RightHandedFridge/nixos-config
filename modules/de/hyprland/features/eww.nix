{ config, osConfig, ... }:{
  programs.eww = {
    enable = true;
    configDir = "/home/${osConfig.vars.user}/nixos-config/modules/de/hyprland/features/eww";
  };
}