{ config, lib, ... }: {
  options.modules.programs.multimedia.ffmpeg = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.modules.programs.multimedia.enable;
        description = "Enable FFmpeg";
      };
  };

  imports = [
    ./hm.nix
  ];
}
