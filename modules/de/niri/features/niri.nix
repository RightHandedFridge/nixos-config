{
  pkgs,
  lib,
  config,
  osConfig,
}: {
  config = lib.mkIf osConfig.modules.de.niri.enable {
    xdg.configFile."niri/config.kdl".text = ''
      input {
        disable-power-key-handling
        focus-follows-mouse max-scroll-amount="10%"
        mod-key "Super"
      }
    '';
  };
}
