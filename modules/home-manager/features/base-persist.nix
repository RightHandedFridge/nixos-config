{config, ...}: {
  home.persistence."/persist/home/${config.vars.user}" = config.modules.impermanence.enable {
    directories = [
      ".local/state/wireplumber"
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      ".ssh"
      ".local/share/keyrings"
      ".local/share/direnv"
      "KeePass"
      ".config/sops/age/"
      "nixos-config"
      ".config/syncthing"
      ".local/share/Paradox Interactive"
      ".config/fingerprint"
    ];

    files = [
      ".bash_history"
      ".gitconfig"
    ];
    allowOther = true;
  };
}
