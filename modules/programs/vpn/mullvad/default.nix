{ lib, config, ... }: {
  options.modules.programs.vpn.mullvad = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.modules.programs.vpn.enable;
      description = "Enable Mullvad VPN.";
    };
  };

  imports = [
    ./nixos.nix
  ];
}
