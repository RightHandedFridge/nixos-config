{
  config,
  pkgs,
  osConfig,
  lib,
  ...
}: {
  imports = [
    ../features/vscode.nix
    ../features/firefox.nix
    ../features/alacritty.nix
    ../features/tealdeer.nix
    ../features/base-persist.nix
    ../features/vars.nix
    ../features/neovim.nix
    ../features/solaar.nix
  ];

  home.packages = with pkgs; [
    libreoffice-qt6-fresh
    keepassxc
    nixd
    alejandra
    kdePackages.qt6ct
    libsForQt5.qt5ct
    networkmanagerapplet
    mullvad-browser
    vlc
    vesktop
  ];

  services.arrpc.enable = true; #required for Vesktop to detect games
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
  };

  programs.firefox.enable = true;
  programs.alacritty.enable = true;

  home.persistence."/persist/home/${config.vars.user}" = lib.mkIf osConfig.modules.system.impermanence.enable {
    directories = [
      ".config/Mullvad VPN"
      ".local/share/Steam/"
      ".config/discord"
      ".config/vesktop"
      ".config/vencord"
      ".config/pulse"
      ".config/heroic"
    ];
  };

  xdg.configFile."keepassxc/keepassxc.ini".text = ''
    [General]
    ConfigVersion=2

    [GUI]
    ApplicationTheme=dark
  '';
}
