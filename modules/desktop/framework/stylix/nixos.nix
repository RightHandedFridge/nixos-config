{ lib, config, pkgs, ... }:{
  config = lib.mkIf config.modules.desktop.framework.stylix.enable {
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/hardcore.yaml";
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