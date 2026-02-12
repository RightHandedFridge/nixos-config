{ lib, ... }: {
  options.modules.programs.vpn.mullvad = {
    enable = lib.mkEnableOption "Enable Mullvad VPN";
  };

  imports = [
    ./nixos.nix
  ];
}
