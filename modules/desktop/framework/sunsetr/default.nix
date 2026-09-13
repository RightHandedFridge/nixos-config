{ lib, config, ... }: {
  options.modules.desktop.framework.sunsetr = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.modules.desktop.framework.enable;
      description = "Enable Sunsetr.";
    };
  };

  imports = [
    ./hm.nix
  ];
}
