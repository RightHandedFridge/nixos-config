{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "nvme" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];

  networking.useDHCP = lib.mkDefault true;

  fileSystems = lib.mkIf (!config.modules.system.impermanence.enable) {
    "/" =
      { device = "/dev/disk/by-uuid/845d2da5-cef5-46fe-8109-7c3af14b49a8";
        fsType = "ext4";
      };

    "/boot" =
      { device = "/dev/disk/by-uuid/64D0-2A53";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };
  };

  swapDevices = lib.mkIf (!config.modules.system.impermanence.enable) [
    { device = "/dev/disk/by-uuid/3453869e-1214-46e3-b19b-ca770b67960c"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}