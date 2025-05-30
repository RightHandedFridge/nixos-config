{
  lib,
  config,
  ...
}: let
  cfg = config.modules.system.syncthing;
in {
  options.modules.system = {
    syncthing.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Syncthing";
    };
  };

  config = lib.mkIf cfg.enable {
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
            id = "LLXW7EH-SGSR6Q7-67YDMSY-BTNDN4U-RI6SBDY-BTYCPRG-HGLWGXA-ZPTHXAB";
          };
        };

        folders = {
          "Personal" = {
            path = "~/KeePass/Personal";
            devices = ["HomeServer"];
            ignorePerms = true;
          };

          "Home" = {
            path = "~/KeePass/Home";
            devices = ["HomeServer"];
            ignorePerms = true;
          };

          "Sops" = {
            path = "~/.config/sops/age/";
            devices = ["HomeServer"];
            ignorePerms = true;
          };
        };
      };
    };
    systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
  };
}
