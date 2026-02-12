{ lib, ... }:{
  options.programs.multimedia.krita = {
    enable = lib.mkEnableOption "Enable Krita multimedia application";
  };

  imports = [
    ./hm.nix
  ];
}