{ lib
, config
, pkgs
, ...
}: {
  home-manager.users.${config.vars.user} = lib.mkIf config.programs.multimedia.kdenlive.enable {
    home.packages = with pkgs; [
      kdePackages.kdenlive
    ];
  };
}
