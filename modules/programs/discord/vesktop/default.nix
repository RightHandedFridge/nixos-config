{ lib, ... }:{
  options.programs.discord.vesktop = {
    enable = lib.mkEnableOption "Enable Vesktop";
  };

  imports = [
    ./hm.nix
  ];
}