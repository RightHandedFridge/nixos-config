{pkgs, ...}: {
  services.udev.packages = with pkgs; [
    android-tools
  ];
  environment.systemPackages = with pkgs; [
    android-tools
  ];
}
