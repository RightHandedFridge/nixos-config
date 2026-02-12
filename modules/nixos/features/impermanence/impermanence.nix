{ lib, config, ... }:

let
  cfg = config.modules.system.impermanence;
in
{
  options.modules.system.impermanence = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable NixOS Impermanence, Requires Additional Configuration";
    };
  };

  imports = [
    ./reset.nix
  ];

  config = lib.mkIf cfg.enable {

    # /persist is needed for boot when impermanence is enabled
    fileSystems."/persist".neededForBoot = true;

    # Define persistence for system-wide directories
    environment.persistence."/persist/system" = {
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
        {
          directory = "/var/lib/colord";
          user = "colord";
          group = "colord";
          mode = "u=rwx,g=rx,o=";
        }
      ];
    };

    # Create persistent home directories
    systemd.tmpfiles.rules = [
      "d /persist/home/ 1777 root root -" # /persist/home created, owned by root
      "d /persist/home/${config.vars.user} 0770 ${config.vars.user} users -" # /persist/home/<user> created, owned by that user
    ];

    # Set a static machine-id to avoid issues with journalctl
    environment.etc."machine-id".text = "4ba5fb6bf37841bfb576ab28d7d16765";
  };
}
