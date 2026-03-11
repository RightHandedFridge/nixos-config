{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.modules.programs.shell.bash.enable {
    programs.obs-studio.enableVirtualCamera = true;
  };
}
