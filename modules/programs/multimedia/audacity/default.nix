{ config, lib, ...}: {
  options.modules.programs.multimedia.audacity = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.modules.programs.multimedia.enable;
        description = "Enable Audacity";
      };
  };

  imports = [
    ./nixos.nix
  ];
}
