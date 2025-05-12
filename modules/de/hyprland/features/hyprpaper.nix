{
  osConfig,
  config,
  lib,
  ...
}: {

  config = lib.mkIf osConfig.modules.de.hyprland.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [
          "/home/${osConfig.vars.user}/nixos-config/modules/de/hyprland/features/nix-wallpaper.png"
        ];

        wallpaper = [
          ", /home/${osConfig.vars.user}/nixos-config/modules/de/hyprland/features/nix-wallpaper.png"
        ];
      };
    };
  };
}

