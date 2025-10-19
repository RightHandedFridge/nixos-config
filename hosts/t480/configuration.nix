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
    "/etc/nixos/hardware-configuration.nix"
    ../../modules/hardware/bluetooth.nix
    #../../modules/hardware/fingerprint.nix

    #Modules
    ../../modules/nixos/bundles/system.nix
    ../../modules/nixos/bundles/user-sys-packages.nix

    #Desktop Enviroment
    ../../modules/de/kde/bundles/kde-nixos.nix
    ../../modules/de/hyprland/bundles/hyprland-nixos.nix

    #Secrets
    ../../modules/sops/sops.nix

    #Home Manager
    inputs.home-manager.nixosModules.default
  ];

  modules = {
    system = {
      hm = {
        enable = true;
      };
      impermanence = {
        enable = false;
      };
      games = {
        enable = false;
      };

      syncthing = {
        enable = true;
      };

      virtualisation = {
        enable = false;
      };

      vpn = {
        mullvad = {
          enable = false;
        };
        proton = {
          enable = true;
        };
      };
    };

    de = {
      kde = {
        enable = false;
      };

      hyprland = {
        enable = true;
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
    hashedPasswordFile = config.sops.secrets.x280pass.path;
    extraGroups = ["networkmanager" "wheel"];
  };

  # Set the system state version
  system.stateVersion = "24.11"; # Make sure this matches your installed version of NixOS
}
