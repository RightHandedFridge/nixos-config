{ config
, lib
, ...
}: {
  config = lib.mkIf config.modules.services.flatpak.enable {
    services.flatpak = {
      enable = true;
    };
  };
}
