{...}: {
  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedProxySettings = true;

    virtualHosts."home.arpa" = {
      forceSSL = true;
      sslCertificate = "/etc/ssl/certs/home.arpa.pem";
      sslCertificateKey = "/etc/ssl/private/home.arpa-key.pem";

      locations."^~ /adguard/" = {
        proxyPass = "http://localhost:280/"; # AdGuard Home
        proxyWebsockets = true;
        extraConfig = ''
          rewrite ^/adguard/(.*) /$1 break;
        '';
      };

      locations."^~ /ha/" = {
        proxyPass = "http://localhost:8123/"; # Home Assistant
        proxyWebsockets = true;
        extraConfig = ''
          rewrite ^/ha/(.*) /$1 break;
        '';
      };

      locations."^~ /jellyfin/" = {
        proxyPass = "http://localhost:8096/"; # Jellyfin
        proxyWebsockets = true;
        extraConfig = ''
          rewrite ^/jellyfin/(.*) /$1 break;
        '';
      };

      locations."^~ /syncthing/" = {
        proxyPass = "http://localhost:180/"; # Syncthing
        proxyWebsockets = true;
        extraConfig = ''
          rewrite ^/syncthing/(.*) /$1 break;
        '';
      };
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 80 443 ];
  };
}
