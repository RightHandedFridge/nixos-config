{
  lib,
  osConfig,
  pkgs,
  ...
}: {
  config = lib.mkIf osConfig.modules.de.hyprland.enable {
    programs.rofi = {
      enable = true;
      font = lib.mkForce "Inter 14";
      plugins = with pkgs; [
        rofi-calc
        rofi-emoji
        rofi-bluetooth
        rofi-power-menu
        rofi-network-manager
      ];

      extraConfig = {
        show = "drun";
        modi = "drun,run";
        drun-display-format = "{name}";
        disable-history = true;
        matching = "fuzzy";
        case-sensitive = false;
      };
    };
  };
}
