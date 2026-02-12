{ ... }: {
  imports = [
    ../features/hyprland.nix
    ../features/sunsetr.nix
    ../../stylix/stylix-hm.nix
    ../features/rofi.nix
    ../../shells/noctalia/noctalia-hm.nix
  ];

  programs.bash.enable = true;
}
