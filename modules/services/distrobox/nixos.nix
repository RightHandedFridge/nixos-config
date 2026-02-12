{ config
, lib
, ...
}: {
  config = lib.mkIf config.services.distrobox.enable {
    environment.systemPackages = with pkgs; [
      distrobox
    ];

    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
    };
  };
}
