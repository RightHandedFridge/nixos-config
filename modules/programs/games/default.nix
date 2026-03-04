{ lib, ...}: {
  options.modules.programs.games = {
    enable = lib.mkEnableOption "Enable Game Programs";
  };

  imports = [
    ./steam
    ./heroic
    ./prism_launcher
  ];
}
