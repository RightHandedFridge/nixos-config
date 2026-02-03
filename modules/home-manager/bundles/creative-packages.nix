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
<<<<<<< HEAD
=======
    ffmpeg
>>>>>>> 28a6af3 (New: More Packages that I constantly use nix-shell for)
  ];
}
