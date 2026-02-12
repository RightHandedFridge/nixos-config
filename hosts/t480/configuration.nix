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
    ../../modules/hardware/gpu/amd.nix
    ../../modules/hardware/printing.nix
    ../../modules/hardware/bluetooth.nix
    ../../modules/hardware/display.nix
    ../../modules/hardware/logitech/default.nix
    ../../modules/hardware/microphone/default.nix

    #Modules
    ../../modules/nixos/bundles/system.nix
    ../../modules/nixos/bundles/user-sys-packages.nix
    ../../modules/programs
    ../../modules/services

    #Desktop Enviroment
    ../../modules/de/default-nixos.nix

    #Secrets
    ../../modules/sops/sops.nix

    #Home-Manager
    inputs.home-manager.nixosModules.default
  ];

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

  modules = {
    de.hyprland.enable = true;
    system.hm.enable = true;
    system.impermanence.enable = false;
    hardware = {
      logitech.enable = false;
      microphone.enable = false;
    };

    programs = {
      browser = {
        firefox.enable = true;
        tor.enable = true;
      };

      discord = {
        vesktop.enable = true;
      };

      editors = {
        helix.enable = true;
        vscode.enable = true;
        lf.enable = true;
      };

      filemanager = {
        nautilus.enable = true;
      };

      games = {
        steam.enable = false;
        heroic.enable = false;
      };

      keepassxc = {
        enable = true;
      };

      multimedia = {
        ffmpeg.enable = true;
        imagemagick.enable = true;
        kdenlive.enable = true;
        kid3.enable = true;
        krita.enable = true;
        loupe.enable = true;
        obs-studio.enable = true;
        vlc.enable = true;
      };

      tealdeer = {
        enable = true;
      };

      terminal = {
        alacritty.enable = true;
      };

      vpn = {
        proton.enable = true;
        mullvad.enable = true;
      };
    };

    services = {
      android.enable = false;
      distrobox.enable = false;
      flatpak.enable = true;
      nfs.enable = true;
      syncthing.enable = true;
    };
  };
}
