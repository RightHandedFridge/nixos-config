{
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf config.modules.programs.comms.element.enable {
    environment.systemPackages = with pkgs; [
      element-desktop
    ];
  };
}
