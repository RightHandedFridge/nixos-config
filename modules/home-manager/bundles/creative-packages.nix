{pkgs, ...}: {
  home.packages = with pkgs; [
    krita
    obs-studio
    kdePackages.kdenlive
    qbittorrent
    filezilla
    logseq
    imagemagick
    kid3
  ];
}
