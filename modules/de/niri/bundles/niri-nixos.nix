{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  cfg = config.modules.de.niri;
in {
  options.modules.de.niri = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Niri Window Manager Configuration";
    };
  };

  imports = [
  ];

  config = lib.mkIf cfg.enable {
    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };
  };
}
