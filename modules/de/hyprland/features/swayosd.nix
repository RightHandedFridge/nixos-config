{ lib
, osConfig
, ...
}: {
  config = lib.mkIf osConfig.modules.de.hyprland.enable {
    services.swayosd = {
      enable = true;
      topMargin = 0.75;
    };
  };
}
