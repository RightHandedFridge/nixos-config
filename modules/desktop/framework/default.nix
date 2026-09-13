{ lib, ... }: {
  options.modules.desktop.framework = {
    enable = lib.mkEnableOption "Enable Desktop Framework Components";
  };

  imports = [
    ./gnome_keyring
    ./stylix
    ./sunsetr
  ];
}
