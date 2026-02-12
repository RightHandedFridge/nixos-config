{ ... }:{
  config = lib.mkIf config.programs.gui.terminal.alacritty.enable {
    programs.nautilus-open-any-terminal = lib.mkIf config.programs.filemanager.nautilus.enable {
      enable = true;
      terminal = "alacritty";
    };
  };
}