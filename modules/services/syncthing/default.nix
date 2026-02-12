{ lib, ... }: {
  options.services.syncthing = {
    enable = lib.mkEnableOption "Enable Syncthing service";
  };

  imports = [
    ./nixos.nix
  ];
}
