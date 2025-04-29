{pkgs, ...}: {
  home.packages = with pkgs; [
    netbeans
  ];
}
