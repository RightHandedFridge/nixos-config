{ lib, config, ... }: {
  options.modules.programs.comms.vesktop = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.modules.programs.comms.enable;
      description = "Enable Vesktop.";
    };
  };

  imports = [
    ./hm.nix
  ];
}
