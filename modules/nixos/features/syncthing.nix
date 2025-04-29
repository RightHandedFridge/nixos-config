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
      settings = {
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
    systemd.services.syncthing.environment.STNODEFAULTFOLDER = lib.mkIf config.modules.syncthing.enable "true";
  };
}
