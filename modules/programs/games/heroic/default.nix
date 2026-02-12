{ lib, ... }: {
  options.modules.programs.games.heroic = {
    enable = lib.mkEnableOption "Enable Heroic Games Launcher";
  };

  imports = [
    ./nixos.nix
  ];
}
