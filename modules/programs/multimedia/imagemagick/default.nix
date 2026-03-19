{ config, lib, ... }: {
  options.modules.programs.multimedia.imagemagick = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.modules.programs.multimedia.enable;
        description = "Enable ImageMagick";
      };
  };

  imports = [
    ./hm.nix
  ];
}
