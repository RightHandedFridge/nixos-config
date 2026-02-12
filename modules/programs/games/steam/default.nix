{ lib, ... }: {
  options.programs.games.steam = {
    enable = lib.mkEnableOption "Enable Steam";
  };

  imports = [
    ./nixos.nix
  ];
}
