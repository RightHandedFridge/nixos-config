{ lib, ... }: {
  options.modules.services.syncthing = {
    enable = lib.mkEnableOption "Enable Syncthing service";
  };

  imports = [
    ./nixos.nix
  ];
}
