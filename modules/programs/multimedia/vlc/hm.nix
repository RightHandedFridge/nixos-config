{ lib
, config
, pkgs
, ...
}: {
  home-manager.users.${config.vars.user} = lib.mkIf config.modules.programs.multimedia.vlc.enable {
    home.packages = with pkgs; [
      vlc
    ];

    xdg.mimeApps.defaultApplicationPackages = with pkgs; [
      vlc
    ];
  };
}
