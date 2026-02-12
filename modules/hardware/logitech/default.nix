{ lib, ... }:{
  options.hardware.logitech = {
    enable = lib.mkEnableOption "Enable Logitech hardware support";
  };

  imports = [
    ./hm.nix
    ./nixos.nix
  ];
}