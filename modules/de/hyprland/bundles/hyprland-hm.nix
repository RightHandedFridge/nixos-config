{ ... }:{
  imports = [
    ../features/hyprland.nix
    ../features/dunst.nix
    ../features/waybar.nix
    ../features/wofi.nix
    ../features/hyprpaper.nix
    ../features/eww.nix
  ];

  programs.bash.enable = true;
}