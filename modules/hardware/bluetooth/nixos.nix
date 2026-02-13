{ lib, config, pkgs, ... }:{
  config = lib.mkIf config.modules.hardware.bluetooth.enable {
    environment.systemPackages = with pkgs; [ bluez ];
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
        };
      };
    };

    services.blueman = {
      enable = true;
    };
  };
}