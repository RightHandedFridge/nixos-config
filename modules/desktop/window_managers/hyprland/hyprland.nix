{ lib, config, pkgs, ... }:{
  config = lib.mkIf config.modules.desktop.hyprland.enable {
    programs.hyprland = {
      enable = true;
      package = pkgs.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };

    environment = {
      sessionVariables.NIXOS_OZONE_WL = "1";
      systemPackages = with pkgs; [
        hyprpolkitagent
        wl-clipboard
        swappy
        hyprshot
        gpu-screen-recorder
      ];
    };
    home-manager.users.${config.vars.user} = {
      wayland.windowManager.hyprland = {
        enable = true;
        systemd = {
          enable = true;
          variables = [ "--all" ];
        };
      };
    };
  };
}