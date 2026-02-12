{ lib, ... }: {
  options.modules.programs.editors.helix = {
    enable = lib.mkEnableOption "Enable Helix editor";
  };

  imports = [
    ./hm.nix
  ];
}
