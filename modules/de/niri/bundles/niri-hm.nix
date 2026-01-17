{
  pkgs,
  inputs,
  osConfig,
  lib,
  ...
}: {
  imports = [
    ../features/niri.nix
    ../../shells/noctalia.nix
  ];
  config =
    lib.mkIf osConfig.modules.de.niri.enable {
    };
}
