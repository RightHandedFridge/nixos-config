{ lib, ... }: {
  options.modules.programs.browser = {
    enable = lib.mkEnableOption "Enable Browser Programs";
  };

  imports = [
    ./tor_browser
    ./firefox
  ];
}
