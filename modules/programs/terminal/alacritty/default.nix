{ lib, ... }: {
  options.programs.terminal.alacritty = {
    enable = lib.mkEnableOption "Enable Alacritty terminal emulator";
  };

  imports = [
    ./hm.nix
    ./nixos.nix
  ];
}
