{ config
, lib
, ...
}: {
  config = lib.mkIf config.services.android.enable {
    services.udev.packages = with pkgs; [
      android-tools
    ];
    environment.systemPackages = with pkgs; [
      android-tools
    ];
  };
}
