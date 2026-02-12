{ config
, lib
, ...
}: {
  config = lib.mkIf config.services.flatpak.enable {
    services.flatpak = {
      enable = true;
    };
  };
}
