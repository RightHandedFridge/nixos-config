{ pkgs, config, lib, ... }: {
  home-manager.users.${config.vars.user} = lib.mkIf config.hardware.logitech.enable {
    systemd.user.services.solaar = {
      Unit = {
        Description = "Solaar (start after graphical session)";
        After = [ "graphical-session.target" ];
        Wants = [ "graphical-session.target" ];
      };

      Service = {
        Type = "simple";
        ExecStart = ''
          ${pkgs.solaar}/bin/solaar --window=hide --battery-icons=symbolic
        '';
        Restart = "on-failure";
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
