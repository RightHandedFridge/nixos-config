{ lib, config, ... }:{
  config = lib.mkIf config.modules.desktop.framework.gnome-keyring.enable {
    services.gnome.gnome-keyring.enable = true;
  };
}