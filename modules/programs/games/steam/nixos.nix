{ ... }: {
  config = lib.mkIf options.programs.games.steam.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    hardware.steam-hardware.enable = true;

    programs.gamemode = {
      enable = true;
    };
  };
}
