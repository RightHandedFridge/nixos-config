{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.modules.programs.multimedia.audacity.enable {
    environment.systemPackages = with pkgs; [
      audacity
    ];
  };
}
