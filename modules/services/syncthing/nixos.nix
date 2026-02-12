{ lib, config, ... }: {
  config = lib.mkIf config.modules.services.syncthing.enable {
    services.syncthing = {
      enable = true;
      user = config.vars.user;
      group = "users";
      configDir = "/home/${config.vars.user}/.config/syncthing";
      dataDir = "/home/${config.vars.user}/.config/syncthing";
      key = config.sops.secrets."${config.vars.host}/syncthing/key".path;
      cert = config.sops.secrets."${config.vars.host}/syncthing/cert".path;
      settings = {
        options = {
          natEnabled = false;
        };
        devices = {
          "HomeServer" = {
            id = "SFS3MRC-FADS62R-3UCULXM-3K76X3D-CC7NNA6-SKS3WLP-SRGMZN7-RNTRMA3";
          };
        };

        folders = {
          "Personal" = {
            path = "~/KeePass/Personal";
            devices = [ "HomeServer" ];
            ignorePerms = true;
          };

          "Home" = {
            path = "~/KeePass/Home";
            devices = [ "HomeServer" ];
            ignorePerms = true;
          };

          "Sops" = {
            path = "~/.config/sops/age/";
            devices = [ "HomeServer" ];
            ignorePerms = true;
          };
        };
      };
    };
    systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
  };
}
