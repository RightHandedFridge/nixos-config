{ config
, lib
, ...
}: {
  config = lib.mkIf config.services.nfs.enable {
    boot.supportedFilesystems = [ "nfs" ];
    services.rpcbind.enable = true;
    environment.systemPackages = with pkgs; [
      nfs-utils
    ];
  };
}
