{ lib
, config
, pkgs
, ...
}: {
  home-manager.users.${config.vars.user} = lib.mkIf config.modules.programs.multimedia.krita.enable {
    home.packages = with pkgs; [
      krita
    ];
  };
}
