{ lib
, config
, pkgs
, ...
}: {
  home-manager.users.${config.vars.user} = lib.mkIf config.modules.programs.multimedia.ffmpeg.enable {
    home.packages = with pkgs; [
      ffmpeg
    ];
  };
}
