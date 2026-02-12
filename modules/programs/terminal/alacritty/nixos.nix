{ lib, config, ... }: {
  config = lib.mkIf config.modules.programs.terminal.alacritty.enable {
    programs.nautilus-open-any-terminal = lib.mkIf config.modules.programs.filemanager.nautilus.enable {
      enable = true;
      terminal = "alacritty";
    };
  };
}
