{pkgs, ...}: {
  #NixOS File

  #All files used by containers must be owned by either main or root
  #but also must be accessible by the "docker" group
  #Otherwise they won't launch

  users.users."root".extraGroups = ["podman"];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings = {dns_enabled = true;};
  };

  environment.systemPackages = with pkgs; [
    dive 
    podman-tui 
    docker-compose 
    podman-compose
    nvidia-container-toolkit
  ];

  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      homeAssistant = {
        image = "ghcr.io/home-assistant/home-assistant:latest";
        autoStart = true;
        hostname = "ha";
        volumes = [
          "/home/main/dconfig/ha-config:/config"
          "/etc/localtime:/etc/localtime:ro"
          "/run/dbus:/run/dbus:ro"
        ];
        extraOptions = [
          "--network=host"
        ];
      };

      nodered = {
        image = "nodered/node-red:latest";
        autoStart = true;
        hostname = "nr";
        volumes = [
          "/home/main/dconfig/nodered:/data"
        ];
        extraOptions = [
          "--network=bridge"
        ];
        ports = [
          "3880:1880/tcp"
        ];
      };

      syncthing = {
        image = "linuxserver/syncthing:latest";
        autoStart = true;
        hostname = "st";
        volumes = [
          "/home/main/dconfig/syncthing/config:/config"
          "/home/main/dconfig/syncthing/sync:/sync"
        ];
        extraOptions = [
          "--network=bridge"
        ];

        ports = [
          "180:8384"
          "22000:22000/tcp"
          "22000:22000/udp"
          "21027:21027/udp"
        ];
      };
    };
  };
}
