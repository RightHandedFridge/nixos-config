{ lib, ... }:{
  options.modules.desktop.framework.stylix = {
    enable = lib.mkEnableOption "Enable Stylix";
  };

  imports = [
    ./nixos.nix
    ./hm.nix
  ];
}