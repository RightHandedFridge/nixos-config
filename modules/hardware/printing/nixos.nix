{ config
, lib
, pkgs
, ...
}: {
  config = lib.mkIf config.modules.hardware.printing.enable {
    services.printing = {
      enable = true;
      drivers = [ pkgs.foo2zjs ];
    };
  };
}
