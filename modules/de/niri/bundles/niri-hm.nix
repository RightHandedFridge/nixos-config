{
  pkgs,
  inputs,
  osConfig,
  lib,
  ...
}: {
  imports = [
    ../features/niri.nix
    ../features/noctalia.nix
  ];
  config =
    lib.mkIf osConfig.modules.de.niri.enable {
    };
}
