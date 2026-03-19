{ lib, ... }: {
  options.modules.hardware.scanner = {
    enable = lib.mkEnableOption "Enable Scanner service";
  };

  imports = [
    ./nixos.nix
  ];
}
