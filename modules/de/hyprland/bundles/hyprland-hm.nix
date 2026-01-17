{...}: {
  imports = [
    ../features/hyprland.nix
    ../features/swaync.nix
    ../features/swayosd.nix
    ../features/waybar.nix
    ../features/hyprpaper.nix
    ../features/sunsetr.nix
    ../../stylix/stylix-hm.nix
    ../features/rofi.nix
    ../features/hyprlock.nix
    ../../shells/noctalia-hm.nix
  ];

  programs.bash.enable = true;
}
