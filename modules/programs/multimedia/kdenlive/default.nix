{ config, lib, ... }: {
  options.modules.programs.multimedia.kdenlive = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.modules.programs.multimedia.enable;
        description = "Enable Kdenlive";
      };
  };

  imports = [
    ./hm.nix
  ];
}
