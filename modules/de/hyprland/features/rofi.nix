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
      font = lib.mkForce "Inter 14";

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

     theme = let
        inherit (config.lib.formats.rasi) mkLiteral;
      in {
        "*" = {
          font = mkLiteral "\"Montserrat 12\"";

          bg0 = mkLiteral "#242424E6";
          bg1 = mkLiteral "#7E7E7E80";
          bg2 = mkLiteral "#0860f2E6";

          fg0 = mkLiteral "#DEDEDE";
          fg1 = mkLiteral "#FFFFFF";
          fg2 = mkLiteral "#DEDEDE80";

          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@fg0";

          margin = 0;
          padding = 0;
          spacing = 0;
        };

        "window" = {
          background-color = mkLiteral "@bg0";
          location = mkLiteral "center";
          width = mkLiteral "50%";
          dynamic = true;
          border-radius = 8;
          padding = mkLiteral "8px";
        };

        "mainbox" = {
          padding = mkLiteral "8px";
          spacing = mkLiteral "8px";
        };

        "inputbar" = {
          font = mkLiteral "\"Montserrat 20\"";
          padding = mkLiteral "12px";
          spacing = mkLiteral "12px";
          children = map mkLiteral [ "icon-search" "entry" ];
        };

        "icon-search" = {
          expand = false;
          filename = mkLiteral "\"search\"";
          size = mkLiteral "28px";
        };

        "icon-search, entry, element-icon, element-text" = {
          vertical-align = mkLiteral "0.5";
        };

        "entry" = {
          font = mkLiteral "inherit";
          placeholder = mkLiteral "\"Search\"";
          placeholder-color = mkLiteral "@fg2";
        };

        "message" = {
          border = mkLiteral "2px 0 0";
          border-color = mkLiteral "@bg1";
          background-color = mkLiteral "@bg1";
        };

        "textbox" = {
          padding = mkLiteral "8px 24px";
        };

        "listview" = {
          dynamic = true;
          lines = 5;
          columns = 1;
          fixed-height = false;
          border = mkLiteral "1px 0 0";
          border-color = mkLiteral "@bg1";
          scrollbar = mkLiteral "true";
        };

        "element" = {
          padding = mkLiteral "8px 16px";
          spacing = mkLiteral "16px";
          background-color = mkLiteral "transparent";
        };

        "element normal active" = {
          text-color = mkLiteral "@bg2";
        };

        "element alternate active" = {
          text-color = mkLiteral "@bg2";
        };

        "element selected normal, element selected active" = {
          background-color = mkLiteral "@bg2";
          text-color = mkLiteral "@fg1";
        };

        "element-icon" = {
          size = mkLiteral "2em";
        };

        "element-text" = {
          text-color = mkLiteral "inherit";
        };
      };
    };
  };
}
