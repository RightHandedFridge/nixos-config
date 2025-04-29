{pkgs, ...}: {
  home.packages = with pkgs; [
    pinta
    obs-studio
    kdePackages.kdenlive
    qbittorrent
    filezilla
  ];
}
