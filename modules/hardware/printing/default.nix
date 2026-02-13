{ lib, ... }: {
  options.modules.hardware.printing = {
    enable = lib.mkEnableOption "Enable Printing service";
  };

  imports = [
    ./nixos.nix
  ];
}
