{ config, lib, pkgs, ... }: {
  home-manager.users.${config.vars.user} = lib.mkIf config.modules.desktop.framework.sunsetr.enable {
    home.packages = with pkgs; [
      sunsetr
    ];

    xdg.configFile."sunsetr/sunsetr.toml".text = ''
      #[Backend]
      backend = "hyprland"
      transition_mode = "finish_by"

      #[Smoothing]
      smoothing = true
      startup_duration = 0.5
      shutdown_duration = 0.5
      adaptive_interval = 1

      #[Time-based config]
      night_temp = 3000
      day_temp = 6500
      night_gamma = 100
      day_gamma = 100
      update_interval = 60

      #[Static config]
      static_temp = 6500
      static_gamma = 100

      #[Manual transitions]
      sunset = "19:00:00"
      sunrise = "05:00:00"
      transition_duration = 30
    '';

    systemd.user.services.sunsetr = {
      Unit = {
        Description = "Sunsetr blue-light filtering";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.sunsetr}/bin/sunsetr -b";
        Restart = "on-failure";
        RestartSec = 1;
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
