{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  cfg = config.modules.de.hyprland;
in {
  options.modules.de.hyprland = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Hyprland desktop environment configuration";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    };

    services = {
      gvfs.enable = true;
      gnome.gnome-keyring.enable = true;
      dbus.enable = true;
    };

    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
      config.common.default = "*";
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    environment.systemPackages = with pkgs; [
      pulseaudio
      brightnessctl
      wev
      hyprpolkitagent
    ];

    fonts.packages = with pkgs; [
      font-awesome
      inter
    ];
  };
}
