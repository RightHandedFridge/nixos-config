{ lib, osConfig, pkgs, ... }:
{
  systemd.user.services.solaar = lib.mkIf osConfig.hardware.logitech.wireless.enable {
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
}
