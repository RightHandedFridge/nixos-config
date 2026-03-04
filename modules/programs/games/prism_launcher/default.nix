{ lib, config, ... }: {
  options.modules.programs.games.prism-launcher = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.modules.programs.games.enable;
      description = "Enable Prism Launcher.";
    };
  };

  imports = [
    ./nixos.nix
  ];
}
