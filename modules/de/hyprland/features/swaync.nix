{ lib
, osConfig
, ...
}: {
  config = lib.mkIf osConfig.modules.de.hyprland.enable {
    services.swaync = {
      enable = true;
      settings = {
        positionX = "right";
        positionY = "top";
        layer = "top";
        cssPriority = "application";
        image-visibility = "when-available";
      };
    };
  };
}
