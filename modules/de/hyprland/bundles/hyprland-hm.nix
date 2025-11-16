{ ... }:{
  imports = [
    ../features/hyprland.nix
    ../features/swaync.nix
    ../features/swayosd.nix
    ../features/waybar.nix
    ../features/wofi.nix
    ../features/hyprpaper.nix
    ../features/hyprsunset.nix
    ../../stylix/stylix-hm.nix
    ../features/rofi.nix
    ../features/hyprlock.nix
  ];

  programs.bash.enable = true;
}
