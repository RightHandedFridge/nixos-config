{ config
, lib
, pkgs
, ...
}: {
  config = lib.mkIf config.modules.hardware.printing.enable {
    hardware.sane = {
      enable = true;
      extraBackends = [
        pkgs.sane-backends
      ];
    };

    environment.systemPackages = with pkgs; [
      simple-scan
    ];

    users.users.${config.vars.user}.extraGroups = ["scanner" "lp"];
  };
}
