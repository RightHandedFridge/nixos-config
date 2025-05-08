{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.modules.de.hyprland.enable {
    services.mako = {
      enable = true;
      icons = true;
    };
  };
}
