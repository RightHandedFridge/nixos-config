{ config, lib, ... }: {
  home-manager.users.${config.vars.user} = lib.mkIf config.modules.programs.keepassxc.enable {
    programs.keepassxc = {
      enable = true;
      settings = {
        gui = {
          ApplicationTheme = "dark";
          HidePasswords = true;
        };
      };
    };
  };
}
