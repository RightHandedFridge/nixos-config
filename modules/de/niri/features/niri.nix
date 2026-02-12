{ lib
, osConfig
, ...
}: {
  config = lib.mkIf osConfig.modules.de.niri.enable {
    xdg.configFile."niri/config.kdl".source = ./config.kdl;
  };
}
