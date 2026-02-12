{ lib, config, pkgs, ... }: {
  config = lib.mkIf config.modules.programs.games.heroic.enable {
    environment.systemPackages = with pkgs; [
      heroic
    ];
  };
}
