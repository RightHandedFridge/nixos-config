{lib, ...}: {
  programs.alacritty.settings = lib.mkForce {
    font.size = 16;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/terminal" = "alacritty.desktop";
    };
  };
}
