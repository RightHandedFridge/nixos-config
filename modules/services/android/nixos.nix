{ config
, lib
, pkgs
, ...
}: {
  config = lib.mkIf config.modules.services.android.enable {
    services.udev.packages = with pkgs; [
      android-tools
    ];
    environment.systemPackages = with pkgs; [
      android-tools
    ];
  };
}
