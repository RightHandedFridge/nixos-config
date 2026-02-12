{ lib
, config
, pkgs
, ...
}: {
  home-manager.users.${config.vars.user} = lib.mkIf config.modules.programs.multimedia.kid3.enable {
    home.packages = with pkgs; [
      kid3
    ];
  };
}
