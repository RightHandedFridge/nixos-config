{ lib, ... }: {
  options.modules.services.flatpak = {
    enable = lib.mkEnableOption "Enable Flatpak service";
  };

  imports = [
    ./nixos.nix
  ];
}
