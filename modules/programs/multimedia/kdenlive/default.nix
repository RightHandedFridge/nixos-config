{ lib, ... }: {
  options.programs.multimedia.kdenlive = {
    enable = lib.mkEnableOption "Enable Kdenlive multimedia application";
  };

  imports = [
    ./hm.nix
  ];
}
