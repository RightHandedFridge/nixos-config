{pkgs, lib, config, osConfig, ...}: {
  home-manager.users.${config.vars.user} = lib.mkIf config.programs.tealdeer.enable {
      home.packages = with pkgs; [
    tealdeer
  ];

  xdg.configFile."tealdeer/config.toml".text = ''
    [display]
    compact = false
    use_pager = false

    [style.command_name]
    foreground = "purple"

    [style.example_text]
    foreground = "green"

    [style.example_code]
    foreground = "blue"

    [style.example_variable]
    foreground = "blue"
    underline = true

    [updates]
    auto_update = true
  '';

  home.persistence."/persist/home/${config.vars.user}" = lib.mkIf osConfig.modules.system.impermanence.enable {
    directories = [
      ".cache/tealdeer"
    ];
  };
  };
}