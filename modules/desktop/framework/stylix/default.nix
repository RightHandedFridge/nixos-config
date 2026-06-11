{ lib, ... }:{
  options.modules.desktop.framework.stylix = {
    enable = lib.mkEnableOption "Enable Stylix";
  };

  imports = [
    ./gtk.nix
    ./qt.nix
    ./hm.nix
    ./nixos.nix
  ];
}