{ lib, config, pkgs, ... }:{
  config = lib.mkIf config.modules.desktop.framework.stylix.enable {
    stylix = {
      enable = true;
      image = ./wallpaper.png;
      targets = {
        console = {
          enable = false;
        };
      };
    };

    fonts.packages = with pkgs; [
      font-awesome
      inter
      nerd-fonts.jetbrains-mono
    ];
  };
}