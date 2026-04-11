{ lib, config, pkgs, ... }: {
  config = lib.mkIf config.modules.programs.vpn.wireguard.enable {
    environment.systemPackages = with pkgs; [
      wireguard-tools
    ];
  };
}
