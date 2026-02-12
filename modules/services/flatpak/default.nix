{ lib, ... }: {
  options.services.flatpak = {
    enable = lib.mkEnableOption "Enable Flatpak service";
  };

  imports = [
    ./nixos.nix
  ];
}
