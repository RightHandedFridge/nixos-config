{ ... }:{
  config = lib.mkIf config.hardware.logitech.enable {
  hardware.logitech = {
    wireless = {
      enable = true;
      enableGraphical = true;
    };
  };
  };
}