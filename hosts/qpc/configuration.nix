# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
  config,
  ...
}: {
  imports = [
    ./vars.nix

    #Hardware
    ./hardware-configuration.nix
    ../../modules/hardware/gpu/amd.nix
    ../../modules/hardware/printing.nix

    #Modules
    ../../modules/nixos/bundles/system.nix
    ../../modules/nixos/bundles/user-sys-packages.nix

    #Desktop Enviroment
    ../../modules/de/kde/kde-nixos.nix
    ../../modules/de/hyprland/hyprland-nixos.nix

    #Secrets
    ../../modules/sops/sops.nix

    #Home-Manager
    inputs.home-manager.nixosModules.default
  ];

  modules = {
    system = {
      hm = {
        enable = true;
      };
      impermanence = {
        enable = true;
      };
      games = {
        enable = true;
      };

      syncthing = {
        enable = true;
      };

      virtualisation = {
        enable = true;
      };

      vpn = {
        mullvad = {
          enable = true;
        };
        proton = {
          enable = true;
        };
      };
    };

    de = {
      kde = {
        enable = true;
      };

      hyprland = {
        enable = false;
      };
    };
  };

  # Set hostname
  networking.hostName = config.vars.host;

  # Default user configuration
  users.users.${config.vars.user} = {
    isNormalUser = true;
    description = config.vars.user;
    initialPassword = "5600";
    hashedPasswordFile = config.sops.secrets.qpcpass.path;
    extraGroups = ["networkmanager" "wheel"];
  };

  # Set the system state version
  system.stateVersion = "24.11"; # Make sure this matches your installed version of NixOS
}
