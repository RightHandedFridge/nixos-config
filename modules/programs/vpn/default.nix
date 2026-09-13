{ lib, ... }: {
  options.modules.programs.vpn = {
    enable = lib.mkEnableOption "Enable VPN Programs";
  };

  imports = [
    ./proton
    ./mullvad
    ./wireguard
  ];
}
