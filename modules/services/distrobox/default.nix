{ lib, config, ... }: {
  options.modules.services.distrobox = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.modules.services.enable;
      description = "Enable Distrobox service.";
    };
  };

  imports = [
    ./nixos.nix
  ];
}
