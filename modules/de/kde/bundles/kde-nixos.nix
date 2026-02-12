{ pkgs
, lib
, config
, ...
}:
let
  cfg = config.modules.de.kde;
in
{
  options.modules.de.kde = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable KDE";
    };
  };

  config = lib.mkIf cfg.enable {
    # Disable the X11 windowing system.
    services.xserver.enable = false;
    services.displayManager.sddm.wayland.enable = true;

    # Make Electron apps use native Wayland
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    # Enable the KDE Plasma Desktop Environment.
    services.desktopManager.plasma6.enable = true;

    environment.plasma6.excludePackages = [
      pkgs.kdePackages.konsole
    ];

    environment.systemPackages = with pkgs; [
      kdePackages.sddm-kcm
      kdePackages.kcoreaddons
      kdePackages.plasma-desktop
      kdePackages.plasma-workspace
      kdePackages.xdg-desktop-portal-kde
      kdePackages.filelight
      whitesur-kde
      whitesur-icon-theme
      whitesur-cursors
      kdePackages.krohnkite
    ];

    services.dbus.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
    };

    fonts.packages = with pkgs; [
      inter
    ];

    services.displayManager.sddm = {
      enable = true;
      theme = "WhiteSur-dark";
      extraPackages = with pkgs; [
        kdePackages.plasma-desktop
        kdePackages.qtsvg
      ];
    };
  };
}
