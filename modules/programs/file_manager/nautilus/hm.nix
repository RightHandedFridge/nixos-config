{
  pkgs,
  config,
  lib,
  ...
}: {
  home-manager.users.${config.vars.user} = lib.mkIf config.modules.programs.filemanager.nautilus.enable {
    xdg.mimeApps = {
      enable = true;

      defaultApplications = {
        "inode/directory" = ["org.gnome.Nautilus.desktop"];
      };
    };
  };
}
