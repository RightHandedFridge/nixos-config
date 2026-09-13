{ lib, config, ... }: {
  options.modules.programs.vpn.proton = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.modules.programs.vpn.enable;
      description = "Enable Proton VPN.";
    };
  };

  imports = [
    ./nixos.nix
  ];
}
