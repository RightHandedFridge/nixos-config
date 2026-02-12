{ config, lib, pkgs, ... }: {
  home-manager.users.${config.vars.user} = lib.mkIf config.modules.programs.browser.tor.enable {
    home.packages = with pkgs; [
      tor-browser
    ];
  };
}
