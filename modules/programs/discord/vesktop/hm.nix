{ config, lib, ... }:{
  home-manager.users.${config.vars.user} = lib.mkIf config.programs.discord.vesktop.enable {
    programs.vesktop = {
      enable = true;
    };
    
    services.arrpc = {
      enable = true;
    };

    home.persistence."/persist/home/${config.vars.user}" = lib.mkIf config.modules.system.impermanence.enable {
      directories = [
        ".config/vesktop"
        ".config/vencord"
      ];
    };
  };
}