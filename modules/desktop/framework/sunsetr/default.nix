{ lib, ... }:{
  options.modules.desktop.framework.sunsetr = {
    enable = lib.mkEnableOption "Enable Sunsetr";
  };

  imports = [
    ./hm.nix
  ];
}