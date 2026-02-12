{ pkgs, ... }: {
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
}
