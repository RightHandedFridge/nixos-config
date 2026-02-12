{ lib, ... }: {
  options.modules.services.distrobox = {
    enable = lib.mkEnableOption "Enable Distrobox service";
  };

  imports = [
    ./nixos.nix
  ];
}
