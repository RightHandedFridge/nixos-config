{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.modules.programs.shell.bash.enable {
    programs.obs-studio = with pkgs.obs-studio-plugins; {
      enable = true;
      plugins = [
        obs-pipewire-audio-capture
      ];
    };
  };
}
