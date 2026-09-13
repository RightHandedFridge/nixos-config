{ lib, ... }: {
  options.modules.desktop.shells = {
    enable = lib.mkEnableOption "Enable Desktop Shells";
  };

  imports = [
    ./noctalia
  ];
}
