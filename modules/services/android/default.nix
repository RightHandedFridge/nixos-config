{ lib, config, ... }: {
  options.modules.services.android = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.modules.services.enable;
      description = "Enable Android service.";
    };
  };

  imports = [
    ./nixos.nix
  ];
}
