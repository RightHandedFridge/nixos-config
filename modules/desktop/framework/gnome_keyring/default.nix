{ lib, ... }:{
  options.modules.desktop.framework.gnome-keyring = {
    enable = lib.mkEnableOption "Enable GNOME Keyring";
  };

  imports = [
    ./nixos.nix
  ];
}