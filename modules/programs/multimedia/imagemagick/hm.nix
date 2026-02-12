{ lib
, config
, pkgs
, ...
}: {
  home-manager.users.${config.vars.user} = lib.mkIf config.programs.multimedia.imagemagick.enable {
    home.packages = with pkgs; [
      imagemagick
    ];
  };
}
