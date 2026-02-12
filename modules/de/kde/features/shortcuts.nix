{ lib
, osConfig
, config
, ...
}: {
  config = lib.mkIf osConfig.modules.de.kde.enable {
    home.file.".config/kglobalshortcutsrc" = {
      force = true;
      source = config.lib.file.mkOutOfStoreSymlink "${config.vars.configDir}/dotfiles/kde/settings/shortcuts";
    };
  };
}
