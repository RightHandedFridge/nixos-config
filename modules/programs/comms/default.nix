{ lib, ... }: {
  options.modules.programs.comms = {
    enable = lib.mkEnableOption "Enable Communication Programs";
  };

  imports = [
    ./vesktop
    ./element
    ./stoat
  ];
}
