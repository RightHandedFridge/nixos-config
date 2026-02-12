{ lib, ... }: {
  options.modules.programs.games.steam = {
    enable = lib.mkEnableOption "Enable Steam";
  };

  imports = [
    ./nixos.nix
  ];
}
