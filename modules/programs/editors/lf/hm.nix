{
  pkgs,
  config,
  lib,
  ...
}: {
  home-manager.users.${config.vars.user} = lib.mkIf config.modules.programs.editors.lf.enable {
    programs.lf = {
      enable = true;
    };
  };
}
