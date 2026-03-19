{ config, lib, ... }: {
  options.modules.programs.multimedia.kid3 = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.modules.programs.multimedia.enable;
        description = "Enable Kid3";
      };
  };

  imports = [
    ./hm.nix
  ];
}
