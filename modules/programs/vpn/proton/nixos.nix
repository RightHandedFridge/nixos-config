{ lib, config, pkgs, ... }: {
  config = lib.mkIf config.modules.programs.vpn.proton.enable {
    environment.systemPackages = with pkgs; [
      protonvpn-gui
    ];
  };
}
