{ lib, ... }: {
  options.modules.hardware.bluetooth = {
    enable = lib.mkEnableOption "Enable Bluetooth Settings";
  };

  imports = [
    ./nixos.nix
  ];
}
