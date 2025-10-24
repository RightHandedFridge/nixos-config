{ lib, osConfig, ... }:{
  services.hyprsunset = lib.mkIf osConfig.modules.de.hyprland.enable {
    enable = true;
    transitions = {
      sunrise = {
        calendar = "*-*-* 06:00:00";
        requests = [
          [ 
            "temperature"
            "6500"
            "identity"
          ]
        ];
      };

      sunset = {
        calendar = "*-*-* 18:00:00";
        requests = [
          [
            "temperature"
            "3000"
          ]
        ];
      };
    };
  };
}
