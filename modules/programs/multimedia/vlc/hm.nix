{ lib
, config
, ...
}: {
  home-manager.users.${config.vars.user} = lib.mkIf config.programs.multimedia.vlc.enable {
    home.packages = with pkgs; [
      vlc
    ];

    xdg.mimeApps.defaultApplicationPackages = with pkgs; [
      vlc
    ];
  };
}
