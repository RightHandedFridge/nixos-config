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

  imports = [
    #../features/theme.nix
    ../../stylix/stylix-nixos.nix
    ../../shells/noctalia/noctalia-nixos.nix
  ];

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      package = pkgs.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      withUWSM = true;
      xwayland.enable = true;
    };

    services = {
      gvfs.enable = true;
      gnome.gnome-keyring.enable = true;
      dbus.enable = true;
    };

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = false;

      config.common.default = "*";

      extraPortals = with pkgs; [
        xdg-desktop-portal
      ];

      wlr.enable = false;
    };

    systemd.user.services.xdg-desktop-portal = {
      after = ["xdg-desktop-portal-hyprland.service"];
      requires = ["xdg-desktop-portal-hyprland.service"];
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    environment.systemPackages = with pkgs; [
      pulseaudio
      brightnessctl
      wev
      hyprpolkitagent
      whitesur-kde
    ];

    fonts.packages = with pkgs; [
      font-awesome
      inter
      nerd-fonts.jetbrains-mono
    ];
  };
}
