{ lib, ...}: {
  options.modules.programs.multimedia = {
    enable = lib.mkEnableOption "Enable Multimedia Programs";
  };

  imports = [
    ./loupe
    ./imagemagick
    ./kdenlive
    ./ffmpeg
    ./obs_studio
    ./vlc
    ./krita
    ./kid3
    ./audacity
  ];
}
