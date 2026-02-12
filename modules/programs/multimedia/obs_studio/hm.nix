{ lib
, config
, pkgs
, ...
}: {
  home-manager.users.${config.vars.user} = lib.mkIf config.programs.multimedia.obs-studio.enable {
    home.packages = with pkgs; [
      obs-studio
    ];
  };
}
