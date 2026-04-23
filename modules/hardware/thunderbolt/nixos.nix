{ config
, lib
, pkgs
, ...
}: {
  config = lib.mkIf config.modules.hardware.thunderbolt.enable {
    services.hardware.bolt.enable = true;
  };
}
