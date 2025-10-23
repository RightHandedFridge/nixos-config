{ ... }:{
  imports = [
    ../features/hyprland.nix
    ../features/dunst.nix
    ../features/waybar.nix
    ../features/wofi.nix
    ../features/hyprpaper.nix
    ../features/hyprsunset.nix
  ];

  programs.bash.enable = true;
}
