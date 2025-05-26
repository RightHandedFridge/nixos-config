{
  pkgs,
  config,
  ...
}: {
  #This is a home manager module
  home.packages = with pkgs; [
    easyeffects
  ];

  home.file.".config/easyeffects/input/lpxw.json" = {
    source = config.lib.file.mkOutOfStoreSymlink ../../dotfiles/easyeffects/lpxw.json;
    force = true;
  };

  systemd.user.services.easyeffects = {
    Install.WantedBy = ["graphical-session.target"];
    Unit = {
      Description = "Easyeffects preset loader";
      Requires = ["dbus.service"];
      After = ["graphical-session-pre.target" "pipewire.service"];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.easyeffects}/bin/easyeffects --load-preset lpxw";
    };
  };
}
