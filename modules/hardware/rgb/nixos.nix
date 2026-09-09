{ config
, lib
, pkgs
, ...
}: {
  config = lib.mkIf config.modules.hardware.rgb.enable {
    services.hardware.openrgb.enable = true;
  };
}
