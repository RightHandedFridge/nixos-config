{ lib, ... }: {
  options.modules.services.nfs = {
    enable = lib.mkEnableOption "Enable NFS service";
  };

  imports = [
    ./nixos.nix
  ];
}
