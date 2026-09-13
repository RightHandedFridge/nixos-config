{ lib, config, ... }: {
  options.modules.programs.editors.vscode = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.modules.programs.editors.enable;
      description = "Enable VSCode.";
    };
  };

  imports = [
    ./hm.nix
  ];
}
