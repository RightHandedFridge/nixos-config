{ ... }:{
  imports = [
    ../features/hyprland.nix
    ../features/dunst.nix
    ../features/waybar.nix
    ../features/wofi.nix
    ../features/hyprpaper.nix
  ];

  programs.bash.enable = true;
}