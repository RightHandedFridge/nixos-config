{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  environment.systemPackages = with pkgs; [
    sops
  ];

  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile =
      if config.modules.system.impermanence.enable
      then "/persist/home/${config.vars.user}/.config/sops/age/keys.txt"
      else "/home/${config.vars.user}/.config/sops/age/keys.txt";

    secrets = {
      x280pass.neededForUsers = true;
      qpcpass.neededForUsers = true;
      hspass.neededForUsers = true;
      "t480/syncthing/key" = {};
      "t480/syncthing/cert" = {};
      "qpc/syncthing/key" = {};
      "qpc/syncthing/cert" = {};
    };
  };
}