{ ... }: {
  config = lib.mkIf config.programs.vpn.proton.enable {
    environment.systemPackages = with pkgs; [
      protonvpn-gui
    ];
  };
}
