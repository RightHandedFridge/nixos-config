{ lib, config, ... }: {
  options.modules.desktop.shells.noctalia = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.modules.desktop.shells.enable;
      description = "Enable Noctalia desktop shell.";
    };
  };

  imports = [
    ./hm.nix
    ./nixos.nix
  ];
}
