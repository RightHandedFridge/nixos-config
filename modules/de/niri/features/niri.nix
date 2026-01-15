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

      binds {
        MOD+SHIFT+K { show-hotkey-overlay; }
        MOD+RETURN hotkey-overlay-title "Open Terminal: Alacritty" { spawn-sh "alacritty";}


        MOD+SPACE hotkey-overlay-title "Open Launcher" { spawn-sh "rofi -show drun";}
        MOD+W hotkey-overlay-title "Launch Browser" { spawn-sh "firefox"; }
        MOD+SHIFT+L hotkey-overlay-title "Lock Screen" { spawn-sh "hyprlock"; }
      }
    '';
  };
}
