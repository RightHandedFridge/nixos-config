{ lib, config, pkgs, ... }:
{
  services.displayManager.ly = lib.mkIf config.modules.de.hyprland.enable {
    enable = true;
  };

  services.displayManager.sessionPackages = [
    (
      (pkgs.writeTextDir "share/wayland-sessions/hyprland.desktop" ''
        [Desktop Entry]
        Name=Hyprland
        Comment=Hyprland Wayland Compositor
        Exec=${pkgs.greetd.hyprland}/bin/Hyprland
        Type=Application
      '')
      .overrideAttrs
      (_: {
        passthru.providedSessions = ["hyprland"];
      })
    )
  ];
  
}