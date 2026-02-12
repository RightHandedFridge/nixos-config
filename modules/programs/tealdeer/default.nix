{ lib, ... }: {
  options.modules.programs.tealdeer = {
    enable = lib.mkEnableOption "Enable Tealdeer";
  };

  imports = [
    ./hm.nix
  ];
}
