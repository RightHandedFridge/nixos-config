{ lib, config, ... }: {
  options.modules.services.flatpak = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.modules.services.enable;
      description = "Enable Flatpak service.";
    };
  };

  imports = [
    ./nixos.nix
  ];
}
