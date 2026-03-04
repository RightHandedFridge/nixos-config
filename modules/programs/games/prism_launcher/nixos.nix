{ lib, config, pkgs, ... }: {
  config = lib.mkIf config.modules.programs.games.prism-launcher.enable {
    environment.systemPackages = with pkgs; [
      prismlauncher
    ];
  };
}
