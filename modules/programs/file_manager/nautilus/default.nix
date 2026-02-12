{ lib, ... }:{
  options.programs.filemanager.nautilus = {
    enable = lib.mkEnableOption "Enable Nautilus file manager";
  };

  imports = [
    ./nixos.nix
  ];
}