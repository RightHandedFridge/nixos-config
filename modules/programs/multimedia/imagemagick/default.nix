{ lib, ... }:{
  options.programs.multimedia.imagemagick = {
    enable = lib.mkEnableOption "Enable ImageMagick multimedia application";
  };

  imports = [
    ./hm.nix
  ];
}