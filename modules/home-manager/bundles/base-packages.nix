{
  config,
  pkgs,
  osConfig,
  lib,
  ...
}: {
  imports = [
    ../features/vscode.nix
    ../features/browser.nix
    ../features/alacritty.nix
    ../features/base-persist.nix
  ];

  home.packages = with pkgs; [
    vesktop
    libreoffice-qt6-fresh
    keepassxc
    nixd
    alejandra
    kdePackages.qt6ct
    libsForQt5.qt5ct
    networkmanagerapplet
    mullvad-browser
    vlc
  ];

  services.arrpc.enable = true; #required for Vesktop to detect games
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
  };

  programs.librewolf.enable = true;
  programs.alacritty.enable = true;

  home.persistence."/persist/home/${config.vars.user}" = lib.mkIf osConfig.modules.system.impermanence.enable {
    directories = [
      ".config/keepassxc"
      ".config/Mullvad VPN"
      ".local/share/Steam/"
      ".config/discord"
      ".config/vesktop"
      ".config/vencord"
      ".config/pulse"
    ];
  };
}
