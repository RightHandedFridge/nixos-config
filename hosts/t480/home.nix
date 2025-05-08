{
  config,
  inputs,
  ...
}: {
  imports = [
    ./vars.nix

    #Hardware
    ../../modules/hardware/microphone.nix
    #Desktop Enviroment
    ../../modules/de/kde/kde-hm.nix
    ../../modules/de/hyprland/bundles/hyprland-hm.nix

    #Packages
    ../../modules/home-manager/bundles/base-packages.nix
    ../../modules/home-manager/bundles/work-packages.nix
    ../../modules/home-manager/bundles/creative-packages.nix

    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  nixpkgs.config.allowUnfree = true;

  home.username = config.vars.user;
  home.homeDirectory = "/home/${config.vars.user}";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  #Allow home manager to manage itself
  programs.home-manager.enable = true;
}
