{
  config,
  lib,
  ...
}: {
  home-manager.users.${config.vars.user} = lib.mkIf config.modules.programs.comms.vesktop.enable {
    programs.vesktop = {
      enable = true;
    };

    services.arrpc = {
      enable = true;
    };
  };
}
