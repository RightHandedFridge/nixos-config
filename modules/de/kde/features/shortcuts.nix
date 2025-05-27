{
  lib,
  osConfig,
  config,
  ...
}: {
  config = lib.mkIf osConfig.modules.de.kde.enable {
    home.file.".config/kglobalshortcutsrc" = {
      force = true;
      source = ../../../../dotfiles/kde/settings/shortcuts;
    };
  };
}
