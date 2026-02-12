{ lib, ... }: {
  options.modules.programs.multimedia.vlc = {
    enable = lib.mkEnableOption "Enable VLC multimedia application";
  };

  imports = [
    ./hm.nix
  ];
}
