{ lib
, config
, pkgs
, ...
}: {
  home-manager.users.${config.vars.user} = lib.mkIf config.programs.multimedia.loupe.enable {
    home.packages = with pkgs; [
      loupe
    ];

    xdg.mimeApps.defaultApplicationPackages = with pkgs; [
      loupe
    ];
  };
}
