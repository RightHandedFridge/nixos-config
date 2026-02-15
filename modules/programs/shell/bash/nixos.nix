{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.modules.programs.shell.bash.enable {
    programs.bash = {
      enable = true;
      completion.enable = true;
    };
  };
}
