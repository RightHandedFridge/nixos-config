{ lib, ... }:{
  options.modules.desktop.shells.noctalia = {
    enable = lib.mkEnableOption "Enable Noctalia desktop shell";
  };

  imports = [
    ./hm.nix
    ./nixos.nix
  ];
}