{ config
, lib
, pkgs
, ...
}: {
  config = lib.mkIf config.modules.services.distrobox.enable {
    environment.systemPackages = with pkgs; [
      distrobox
    ];

    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
    };
  };
}
