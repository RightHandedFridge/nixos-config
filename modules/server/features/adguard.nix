{ ... }:{
  services.adguardhome = {
    enable = true;
    port = 280;
    mutableSettings = true;
  };

  networking.firewall.allowedTCPPorts = [ 280 53 ];
}