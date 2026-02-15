{
  config,
  lib,
  ...
}: {
  home-manager.users.${config.vars.user} = lib.mkIf config.modules.programs.shell.bash.enable {
    programs.bash.enable = true;
  };
}
