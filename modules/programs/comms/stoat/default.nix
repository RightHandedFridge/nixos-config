{ lib, config, ... }: {
  options.modules.programs.comms.stoat = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.modules.programs.comms.enable;
      description = "Enable Stoat (formerly Revolt).";
    };
  };

  imports = [
    ./nixos.nix
  ];
}
