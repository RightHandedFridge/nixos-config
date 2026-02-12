{ config
, lib
, pkgs
, ...
}: {
  config = lib.mkIf config.modules.services.nfs.enable {
    boot.supportedFilesystems = [ "nfs" ];
    services.rpcbind.enable = true;
    environment.systemPackages = with pkgs; [
      nfs-utils
    ];
  };
}
