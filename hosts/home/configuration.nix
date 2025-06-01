# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  lib,
  inputs,
  config,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./vars.nix
    ./hardware-configuration.nix
    ../../modules/nixos/bundles/system.nix
    ../../modules/server/ssh.nix
    ../../modules/hardware/bluetooth.nix
    ../../modules/hardware/gpu/nvidia.nix
    ../../modules/sops/sops.nix
    ../../modules/server/bundles/server-pkgs.nix
  ];

  # Set hostname
  networking.hostName = config.vars.host;

  # Default user configuration
  users.users.${config.vars.user} = {
    isNormalUser = true;
    description = config.vars.user;
    initialPassword = "5600";
    hashedPasswordFile = config.sops.secrets.hspass.path;
    extraGroups = ["networkmanager" "wheel" "podman"];
  };

  system.stateVersion = "24.11";
}
