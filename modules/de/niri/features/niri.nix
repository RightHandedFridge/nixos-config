{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}: {
  config =
    lib.mkIf osConfig.modules.de.niri.enable {
    };
}
