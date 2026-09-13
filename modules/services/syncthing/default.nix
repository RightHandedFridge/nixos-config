{ lib, config, ... }: {
  options.modules.services.syncthing = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.modules.services.enable;
      description = "Enable Syncthing service.";
    };
  };

  imports = [
    ./nixos.nix
  ];
}
