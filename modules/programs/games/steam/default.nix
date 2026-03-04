{ lib, config, ... }: {
  options.modules.programs.games.steam = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.modules.programs.games.enable;
      description = "Enable Steam and related gaming tools.";
    };
  };

  imports = [
    ./nixos.nix
  ];
}
