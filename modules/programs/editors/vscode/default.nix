{ lib, ... }: {
  options.modules.programs.editors.vscode = {
    enable = lib.mkEnableOption "Enable VSCode";
  };

  imports = [
    ./hm.nix
  ];
}
