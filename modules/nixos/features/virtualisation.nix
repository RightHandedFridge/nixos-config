{
  lib,
  config,
  ...
}: let
  cfg = config.modules.modules.system.virtualisation;
in {
  options.modules.system.virtualisation = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Virtualisation";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.virt-manager = {
      enable = true;
    };

    users.groups.libvirtd.members = ["${config.vars.user}"];

    virtualisation = {
      libvirtd.enable = true;
      spiceUSBRedirection.enable = true;
    };
  };
}
