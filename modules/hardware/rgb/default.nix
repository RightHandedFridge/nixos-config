{ lib, ... }: {
  options.modules.hardware.rgb = {
    enable = lib.mkEnableOption "Enable RGB service";
  };

  imports = [
    ./nixos.nix
  ];
}
