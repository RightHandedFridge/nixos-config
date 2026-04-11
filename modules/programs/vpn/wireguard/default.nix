{ lib, ... }: {
  options.modules.programs.vpn.wireguard = {
    enable = lib.mkEnableOption "Enable Wireguard VPN client";
  };

  imports = [
    ./nixos.nix
  ];
}
