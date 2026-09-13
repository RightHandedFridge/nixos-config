{ lib, config, ... }: {
  options.modules.programs.comms.element = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.modules.programs.comms.enable;
      description = "Enable Element.";
    };
  };

  imports = [
    ./nixos.nix
  ];
}
