{lib, ...}: {
  programs.alacritty.settings = lib.mkForce {
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
}
