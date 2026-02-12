{ pkgs
, inputs
, ...
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
    dig
    tree
  ];

  #For nixd
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs-stable}" ];
}
