{ lib, config, ... }: {
  options.modules.programs.editors.helix = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.modules.programs.editors.enable;
      description = "Enable Helix editor.";
    };
  };

  imports = [
    ./hm.nix
  ];
}
