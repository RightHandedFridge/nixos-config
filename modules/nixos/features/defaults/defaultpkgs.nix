{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    tealdeer
    fastfetch
    git
    wget
    btop
    killall
    util-linux
    usbutils
  ];

  #For nixd
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
