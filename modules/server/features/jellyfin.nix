{ config, ... }:{
  services.jellyfin = {
    enable = true;
    configDir = "/home/${config.vars.user}/dconfig/jellyfin/config";
    dataDir = "/home/${config.vars.user}/dconfig/jellyfin/data";
    cacheDir = "/home/${config.vars.user}/dconfig/jellyfin/cache";
    openFirewall = true;
    user = "${config.vars.user}";
    group = "users";
  };
}