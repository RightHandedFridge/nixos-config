{ lib, config, ... }: {
  options.modules.programs.editors.lf = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.modules.programs.editors.enable;
      description = "Enable lf.";
    };
  };

  imports = [
    ./hm.nix
  ];
}
