{ inputs
, pkgs
, lib
, config
, pkgs-unstable
, ...
}: {
  config = lib.mkIf config.modules.desktop.shells.noctalia.enable {
    environment.systemPackages = [
      pkgs-unstable.noctalia-shell
    ];
  };
}
