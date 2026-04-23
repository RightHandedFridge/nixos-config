{ lib, ... }: {
  options.modules.hardware.thunderbolt = {
    enable = lib.mkEnableOption "Enable Thunderbolt service";
  };

  imports = [
    ./nixos.nix
  ];
}
