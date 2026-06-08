{
  lib,
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  config = lib.mkIf config.modules.programs.games.steam.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    hardware.steam-hardware.enable = true;

    programs.gamemode = {
      enable = true;
    };

    environment.systemPackages = [
      pkgs.r2modman
      pkgs-unstable.deadlock-mod-manager
    ];
  };
}
