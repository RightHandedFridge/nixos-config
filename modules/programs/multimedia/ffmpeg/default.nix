{ lib, ... }:{
  options.programs.multimedia.ffmpeg = {
    enable = lib.mkEnableOption "Enable FFmpeg multimedia application";
  };

  imports = [
    ./hm.nix
  ];
}