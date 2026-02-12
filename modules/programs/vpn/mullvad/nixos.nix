{ ... }: {
  config = lib.mkIf config.programs.vpn.mullvad.enable {
    services.mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
  };
}
