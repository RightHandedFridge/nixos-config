{
  lib,
  osConfig,
  config,
  ...
}: {
  config = lib.mkIf osConfig.modules.de.kde.enable {
    home.file.".config/kwinoutputconfig.json" = {
      force = true;
      source = ../../../../dotfiles/kde/${config.vars.host}-display.json;
    };

    home.file.".config/kwinrc" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.vars.configDir}/dotfiles/kde/settings/kwinrc";
    };
  };
}
