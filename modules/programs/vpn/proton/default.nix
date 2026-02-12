{ lib, ... }: {
  options.modules.programs.vpn.proton = {
    enable = lib.mkEnableOption "Enable Proton VPN";
  };

  imports = [
    ./nixos.nix
  ];
}
