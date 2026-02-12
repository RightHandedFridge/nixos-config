{ lib, ... }: {
  options.modules.services.android = {
    enable = lib.mkEnableOption "Enable Android service";
  };

  imports = [
    ./nixos.nix
  ];
}
