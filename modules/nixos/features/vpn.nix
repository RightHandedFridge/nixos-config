{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.system.vpn = {
    mullvad.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Mullvad VPN service";
    };

    proton.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Proton VPN service";
    };
  };

  config = {
    services.mullvad-vpn = lib.mkIf config.modules.system.vpn.mullvad.enable {
      enable = true;
      package = pkgs.mullvad-vpn;
    };

    environment.persistence."/persist/system" = lib.mkIf config.modules.system.vpn.mullvad.enable {
      hideMounts = true;
      directories = [
        "/etc/mullvad-vpn/"
      ];
    };

    environment.systemPackages = lib.mkIf config.modules.system.vpn.proton.enable [
      pkgs.protonvpn-gui
    ];
  };
}
