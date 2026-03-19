{ config, lib, ... }: {
  options.modules.programs.multimedia.loupe = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.modules.programs.multimedia.enable;
        description = "Enable Loupe";
      };
  };

  imports = [
    ./hm.nix
  ];
}
