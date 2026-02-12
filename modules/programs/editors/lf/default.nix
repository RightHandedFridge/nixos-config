{lib, ...}: {
  options.modules.programs.editors.lf = {
    enable = lib.mkEnableOption "Enable lf";
  };

  imports = [
    ./hm.nix
  ];
}
