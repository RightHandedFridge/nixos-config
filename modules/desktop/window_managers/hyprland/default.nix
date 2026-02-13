{ lib, ... }:{
  options.modules.desktop.hyprland = {
    enable = lib.mkEnableOption "Enable Hyprland desktop environment";
  };

  imports = [
    ./xdg_desktop_portal.nix
    ./hyprland.nix
    ./settings.nix
  ];
}