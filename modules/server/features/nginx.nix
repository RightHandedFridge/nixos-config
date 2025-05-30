{...}: {
  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedProxySettings = true;

    virtualHosts = {
      "ha.home.arpa" = {
        forceSSL = false;
        sslCertificate = "/etc/ssl/certs/home.arpa.pem";
        sslCertificateKey = "/etc/ssl/private/home.arpa-key.pem";

        locations."/" = {
          proxyPass = "http://localhost:8123/";
          proxyWebsockets = true;
        };
      };

      "adguard.home.arpa" = {
        forceSSL = true;
        sslCertificate = "/etc/ssl/certs/home.arpa.pem";
        sslCertificateKey = "/etc/ssl/private/home.arpa-key.pem";

        locations."/" = {
          proxyPass = "http://localhost:280/";
          proxyWebsockets = true;
        };
      };

      "jellyfin.home.arpa" = {
        forceSSL = true;
        sslCertificate = "/etc/ssl/certs/home.arpa.pem";
        sslCertificateKey = "/etc/ssl/private/home.arpa-key.pem";

        locations."/" = {
          proxyPass = "http://localhost:8096/";
          proxyWebsockets = true;
        };
      };

      "syncthing.home.arpa" = {
        forceSSL = true;
        sslCertificate = "/etc/ssl/certs/home.arpa.pem";
        sslCertificateKey = "/etc/ssl/private/home.arpa-key.pem";

        locations."/" = {
          proxyPass = "http://localhost:180/";
          proxyWebsockets = true;
        };
      };

      "nodered.home.arpa" = {
        forceSSL = true;
        sslCertificate = "/etc/ssl/certs/home.arpa.pem";
        sslCertificateKey = "/etc/ssl/private/home.arpa-key.pem";

        locations."/" = {
          proxyPass = "http://localhost:3880/";
          proxyWebsockets = true;
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [80 443];
}
