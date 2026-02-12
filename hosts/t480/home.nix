{ config
, inputs
, ...
}: {
  imports = [
    ./vars.nix
    #Desktop Enviroment
    ../../modules/de/default-hm.nix

  ];

  nixpkgs.config.allowUnfree = true;

  home.username = config.vars.user;
  home.homeDirectory = "/home/${config.vars.user}";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  #Allow home manager to manage itself
  programs.home-manager.enable = true;
}
