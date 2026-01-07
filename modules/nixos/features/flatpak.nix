{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.modules.system.hm.enable {
    services.flatpak = {
      enable = true;
    };

    home-manager.users.${config.vars.user} = {
      home.persistence."/persist/home/${config.vars.user}" = lib.mkIf config.modules.system.impermanence.enable {
        directories = [
          ".local/share/flatpak"
          ".var/app"
        ];
        allowOther = true;
      };
    };

    environment.persistence."/persist/system" = lib.mkIf config.modules.system.impermanence.enable {
      hideMounts = true;
      directories = [
        "/var/lib/flatpak"
      ];
    };
  };
}
