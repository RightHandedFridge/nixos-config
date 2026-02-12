{ lib
, config
, ...
}: {
  home-manager.users.${config.vars.user} = lib.mkIf config.modules.programs.terminal.alacritty.enable {
    programs.alacritty = lib.mkForce {
      enable = true;
      settings.font.size = 16;
    };

    xdg.mimeApps = {
      enable = true;
      associations.added = {
        "x-scheme-handler/terminal" = "Alacritty.desktop";
      };
      defaultApplications = {
        "x-scheme-handler/terminal" = "Alacritty.desktop";
      };
    };
  };
}
