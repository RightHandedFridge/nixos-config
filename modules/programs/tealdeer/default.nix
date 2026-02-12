{ lib, ... }: {
  options.programs.tealdeer = {
    enable = lib.mkEnableOption "Enable Tealdeer";
  };

  imports = [
    ./hm.nix
  ];
}
