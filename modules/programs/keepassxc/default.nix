{ lib, ... }: {
  options.modules.programs.keepassxc = {
    enable = lib.mkEnableOption "Enable KeePassXC";
  };

  imports = [
    ./hm.nix
  ];
}
