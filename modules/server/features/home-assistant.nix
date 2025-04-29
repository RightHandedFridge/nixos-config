{ config, ... }:{
  services.home-assistant = {
    enable = true;
    extraComponents = [
      #Defaults
      "analytics"
      "default_config"
      "esphome"
      "my"
      "shopping_list"
      "wled"
      #Custom
      "bluetooth"
      "co2signal"
      "enphase_envoy"
      "nest"
      "govee_ble"
      "mqtt"
      "shelly"
      "systemmonitor"
      "powerwall"
    ];

    configDir = "/home/${config.vars.user}/servercfg/hass";
    config = {
      home-assistant = {
        name = "Home";
        unit_system = "metric";
        time_zone = "Europe/London";
      };

      frontend = {
        themes = "!include_dir_merge_named themes";
      };
    };
  };
}