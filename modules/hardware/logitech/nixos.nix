{ lib, config,... }: {
  config = lib.mkIf config.modules.hardware.logitech.enable {
    hardware.logitech = {
      wireless = {
        enable = true;
        enableGraphical = true;
      };
    };
  };
}
