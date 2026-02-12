{ lib, ... }: {
  options.modules.programs.multimedia.loupe = {
    enable = lib.mkEnableOption "Enable Loupe multimedia application";
  };

  imports = [
    ./hm.nix
  ];
}
