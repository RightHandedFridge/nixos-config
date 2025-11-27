{pkgs, ...}: {
  services.udev.packages = with pkgs; [
    android-tools
  ];
}
