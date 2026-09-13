{ lib, config, ... }: {
  options.modules.programs.filemanager.nautilus = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.modules.programs.filemanager.enable;
      description = "Enable Nautilus file manager.";
    };
  };

  imports = [
    ./nixos.nix
    ./hm.nix
  ];
}
