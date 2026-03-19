{ config, lib, ... }: {
  options.modules.programs.multimedia.krita = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.modules.programs.multimedia.enable;
        description = "Enable Krita";
      };
  };

  imports = [
    ./hm.nix
  ];
}
