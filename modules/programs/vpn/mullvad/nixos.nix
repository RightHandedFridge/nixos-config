{ lib, config, pkgs , ... }: {
  config = lib.mkIf config.modules.programs.vpn.mullvad.enable {
    services.mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
  };
}
