{ lib, ... }: {
  options.programs.multimedia.kid3 = {
    enable = lib.mkEnableOption "Enable Kid3 multimedia application";
  };

  imports = [
    ./hm.nix
  ];
}
