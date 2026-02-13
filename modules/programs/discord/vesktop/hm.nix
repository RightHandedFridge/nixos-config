{ config, lib, ... }: {
  home-manager.users.${config.vars.user} = lib.mkIf config.modules.programs.discord.vesktop.enable {
    programs.vesktop = {
      enable = true;
    };

    services.arrpc = {
      enable = true;
    };
  };
}
