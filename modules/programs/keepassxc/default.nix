{ lib, ... }:{
  options.programs.keepassxc.enable = {
    enable = lib.mkEnableOption "Enable KeePassXC";
  };

  imports = [
    ./hm.nix
  ];
}