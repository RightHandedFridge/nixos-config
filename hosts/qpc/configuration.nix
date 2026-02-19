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
    ../../modules/hardware

    #Modules
    ../../modules/nixos/bundles/system.nix
    ../../modules/nixos/bundles/user-sys-packages.nix
    ../../modules/programs
    ../../modules/services
    ../../modules/desktop

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
    system.hm.enable = true;
    hardware = {
      logitech.enable = true;
      microphone.enable = true;
      bluetooth.enable = true;
      gpu.amd.enable = true;
      printing.enable = true;
    };

    desktop = {
      shells.noctalia.enable = true;
      hyprland.enable = true;
      framework = {
        gnome-keyring.enable = true;
        stylix.enable = true;
        sunsetr.enable = true;
      };
    };

    programs = {
      shell = {
        bash.enable = true;
      };
      browser = {
        firefox.enable = true;
        tor.enable = true;
      };

      comms = {
        vesktop.enable = true;
        element.enable = true;
        stoat.enable = true;
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
        steam.enable = true;
        heroic.enable = true;
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
      android.enable = true;
      distrobox.enable = true;
      flatpak.enable = true;
      nfs.enable = true;
      syncthing.enable = true;
    };
  };
}
