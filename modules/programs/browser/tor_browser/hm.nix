{ ... }: {
  home-manager.users.${config.vars.user} = lib.mkIf config.programs.browser.tor.enable {
    home.packages = with pkgs; [
      tor-browser
    ];
  };
}
