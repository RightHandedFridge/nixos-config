{
  lib,
  config,
  pkgs-unstable,
  ...
}: {
  config = lib.mkIf config.modules.programs.comms.stoat.enable {
    environment.systemPackages = [
      pkgs-unstable.stoat-desktop
    ];
  };
}
