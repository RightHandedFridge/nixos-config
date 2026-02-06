{...}: {
  imports = [
    ../features/vpn.nix
    ../features/syncthing.nix
    ../features/gaming.nix
    ../features/virtualisation.nix
    ../features/hm.nix
    ../features/android.nix
    ../features/flatpak.nix
    ../features/distrobox.nix
    ../features/nfs.nix
  ];
}
