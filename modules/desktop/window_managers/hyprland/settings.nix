{
  config,
  lib,
  ...
}: {
  home-manager.users.${config.vars.user} = lib.mkIf config.modules.desktop.hyprland.enable {
    wayland.windowManager.hyprland = {
      configType = "lua";
      settings = {};
      extraConfig = builtins.readFile ./hyprland.lua;
    };
  };
}
