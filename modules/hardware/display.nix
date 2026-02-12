{ pkgs
, config
, ...
}: {
  environment.systemPackages = with pkgs; [
    ddcutil
  ];

  hardware.i2c.enable = true;
  services.udev = {
    enable = true;
    extraRules = ''
      KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
    '';
  };

  users.users.${config.vars.user}.extraGroups = [ "i2c" ];
}
