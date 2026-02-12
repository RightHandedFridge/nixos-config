{ inputs
, pkgs
, lib
, config
, pkgs-unstable
, ...
}: {
  config = lib.mkIf (config.modules.de.niri.enable || config.modules.de.hyprland.enable) {
    environment.systemPackages = [
      pkgs-unstable.noctalia-shell
    ];
  };
}
