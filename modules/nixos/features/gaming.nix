{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.system.games;
in {
  options.modules.system = {
    games.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Gaming";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      heroic
      prismlauncher
    ];

    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    programs.gamemode = {
      enable = true;
    };
  };
}
