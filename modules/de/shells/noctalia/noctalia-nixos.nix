{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf (config.modules.de.niri.enable || config.modules.de.hyprland.enable) {
    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
