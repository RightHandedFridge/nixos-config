{
  lib,
  osConfig,
  pkgs,
  config,
  ...
}: {
  config = lib.mkIf osConfig.modules.de.hyprland.enable {
    home.packages = with pkgs; [
      rofi-bluetooth
      rofi-network-manager
    ];
    programs.rofi = {
      enable = true;

      plugins = with pkgs; [
        rofi-calc
        rofi-emoji
        rofi-power-menu
      ];

      extraConfig = {
        show = "drun";
        modi = "drun,run";
        drun-display-format = "{name}";
        disable-history = true;
        matching = "fuzzy";
        case-sensitive = false;
        icon-theme = "WhiteSur-dark";
        show-icons = true;
      };

      theme = ./spotlight-dark.rasi;
    };
  };
}
