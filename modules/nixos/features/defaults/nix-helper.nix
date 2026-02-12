{ config, ... }:
{
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep 2 --keep-since 3d";
    };
    flake = "/home/${config.vars.user}/nixos-config";
  };
}
