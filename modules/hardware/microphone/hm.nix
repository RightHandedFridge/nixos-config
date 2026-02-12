{ pkgs
, config
, osConfig
, lib
, ...
}: {
  #TODO: Fix this, use Home Manager options instead
  home-manager.users.${config.vars.user} = lib.mkIf config.modules.hardware.microphone.enable {
    home.packages = with pkgs; [
      easyeffects
    ];

   home.file.".config/easyeffects/input/lpxw.json" = {
    source = "/home/${config.vars.user}/nixos-config/dotfiles/easyeffects/lpxw.json";
    force = true;
  };


    systemd.user.services.easyeffects = {
      Install.WantedBy = [ "graphical-session.target" ];
      Unit = {
        Description = "Easyeffects preset loader";
        Requires = [ "dbus.service" ];
        After = [ "graphical-session-pre.target" "pipewire.service" ];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.easyeffects}/bin/easyeffects --gapplication-service -l lpxw";
      };
    };
  };
}
