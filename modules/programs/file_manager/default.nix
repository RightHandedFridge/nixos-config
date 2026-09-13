{ lib, ... }: {
  options.modules.programs.filemanager = {
    enable = lib.mkEnableOption "Enable File Manager Programs";
  };

  imports = [
    ./nautilus
  ];
}
