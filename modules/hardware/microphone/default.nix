{ lib, ... }: {
  options.hardware.microphone = {
    enable = lib.mkEnableOption "Enable Microphone Settings";
  };

  imports = [
    ./hm.nix
  ];
}
