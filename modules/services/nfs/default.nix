{ lib, config, ... }: {
  options.modules.services.nfs = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.modules.services.enable;
      description = "Enable NFS service.";
    };
  };

  imports = [
    ./nixos.nix
  ];
}
