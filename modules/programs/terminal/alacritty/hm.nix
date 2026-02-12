{ lib
, config
, ...
}: {
  home-manager.users.${config.vars.user} = lib.mkIf config.programs.terminal.alacritty.enable {
    programs.alacritty.settings = lib.mkForce {
      enable = true;
      font.size = 16;
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
