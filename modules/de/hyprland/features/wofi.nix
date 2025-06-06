{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.modules.de.hyprland.enable {
    programs.wofi = lib.mkForce {
      enable = true;
      settings = {
        allow-images = true;
        show_icons = true;
      };
      style = ''
        window {
          background-color: rgba(36, 36, 36, 0.9);
          border-radius: 8px;
          padding: 10px;
        }

        #input {
          font-family: "Inter";
          font-size: 20px;
          color: #DEDEDE;
          background-color: rgba(126, 126, 126, 0.5);
          padding: 10px;
          border-radius: 4px;
        }

        #inner-box {
          background-color: transparent;
          margin: 10px;
        }

        #outer-box {
          background-color: transparent;
          padding: 10px;
        }

        #scroll {
          background-color: transparent;
        }

        #entry {
          font-family: "Montserrat";
          font-size: 14px;
          color: #DEDEDE;
          padding: 10px;
          border-radius: 4px;
        }

        #entry:selected {
          background-color: rgba(8, 96, 242, 0.9);
          color: #FFFFFF;
        }

        #text {
          color: inherit;
        }

        #img {
          margin-right: 8px;
        }
      '';
    };
  };
}
