{ lib, config, ... }: {
  options.modules.programs.vpn.wireguard = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.modules.programs.vpn.enable;
      description = "Enable Wireguard VPN client.";
    };
  };

  imports = [
    ./nixos.nix
  ];
}
