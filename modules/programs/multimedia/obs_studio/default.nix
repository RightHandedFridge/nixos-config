{ config, lib, ...}: {
  options.modules.programs.multimedia.obs-studio = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.modules.programs.multimedia.enable;
        description = "Enable OBS Studio";
      };
  };

  imports = [
    ./nixos.nix
  ];
}
