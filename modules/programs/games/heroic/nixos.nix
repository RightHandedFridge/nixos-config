{ ... }: {
  config = lib.mkIf options.programs.games.heroic.enable {
    environment.systemPackages = with pkgs; [
      heroic
    ];
  };
}
