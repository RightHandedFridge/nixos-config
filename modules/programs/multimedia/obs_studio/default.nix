{ lib, ... }: {
  options.modules.programs.multimedia.obs-studio = {
    enable = lib.mkEnableOption "Enable OBS Studio multimedia application";
  };

  imports = [
    ./hm.nix
  ];
}
