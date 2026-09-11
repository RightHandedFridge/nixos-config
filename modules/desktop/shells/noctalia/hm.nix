{
  pkgs,
  pkgs-unstable,
  inputs,
  lib,
  osConfig,
  config,
  ...
}: {
  home-manager.users.${config.vars.user} = lib.mkIf config.modules.desktop.shells.noctalia.enable {
    home.packages = with pkgs; [
      hyprshot
      gpu-screen-recorder
      noctalia
    ];

    #Noctalia Settings
    xdg.configFile."noctalia/settings.toml".source = ./settings.toml;
  };
}
