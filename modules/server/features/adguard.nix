{config, pkgs, ...}: {
  services.adguardhome = {
    enable = true;
    openFirewall = false;
    port = 280;
    extraArgs = [
      "--work-dir /home/${config.vars.user}/dconfig/adguard"
    ];
    settings = {
      dns = {
        bind_hosts = [
          "192.168.1.12"
        ];

        port = 53;

        upstream_dns = [
          "https://dns.cloudflare.com/dns-query"
        ];

        upstream_mode = "fastest_addr";
      };
      filtering = {
        rewrites = [
          {
            domain = "home.arpa";
            answer = "192.168.1.12";
          }
          {
            domain = "adguard.home.arpa";
            answer = "192.168.1.12";
          }
          {
            domain = "ha.home.arpa";
            answer = "192.168.1.12";
          }
          {
            domain = "jellyfin.home.arpa";
            answer = "192.168.1.12";
          }
          {
            domain = "syncthing.home.arpa";
            answer = "192.168.1.12";
          }
          {
            domain = "nodered.home.arpa";
            answer = "192.168.1.12";
          }
        ];
      };

      filters = [
        {
          enabled = true;
          url = "https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADhosts.txt";
          name = "KADhosts";
        }
        {
          enabled = true;
          url = "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts";
          name = "FadeMind Spam";
        }
        {
          enabled = true;
          url = "https://v.firebog.net/hosts/static/w3kbl.txt";
          name = "w3kbl";
        }
        {
          enabled = true;
          url = "https://adaway.org/hosts.txt";
          name = "AdAway";
        }
        {
          enabled = true;
          url = "https://v.firebog.net/hosts/AdguardDNS.txt";
          name = "AdguardDNS";
        }
        {
          enabled = true;
          url = "https://v.firebog.net/hosts/Admiral.txt";
          name = "Admiral";
        }
        {
          enabled = true;
          url = "https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt";
          name = "AnudeepND Adservers";
        }
        {
          enabled = true;
          url = "https://v.firebog.net/hosts/Easylist.txt";
          name = "Easylist";
        }
        {
          enabled = true;
          url = "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext";
          name = "Yoyo";
        }
        {
          enabled = true;
          url = "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/UncheckyAds/hosts";
          name = "UncheckyAds";
        }
        {
          enabled = true;
          url = "https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts";
          name = "hostsVN";
        }
        {
          enabled = true;
          url = "https://v.firebog.net/hosts/Easyprivacy.txt";
          name = "EasyPrivacy";
        }
        {
          enabled = true;
          url = "https://v.firebog.net/hosts/Prigent-Ads.txt";
          name = "Prigent-Ads";
        }
        {
          enabled = true;
          url = "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.2o7Net/hosts";
          name = "2o7Net";
        }
        {
          enabled = true;
          url = "https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt";
          name = "WindowsSpyBlocker";
        }
        {
          enabled = true;
          url = "https://hostfiles.frogeye.fr/firstparty-trackers-hosts.txt";
          name = "Frogeye Trackers";
        }
      ];
    };
  };

  networking.firewall = {
    allowedTCPPorts = [53];
    allowedUDPPorts = [53];
  };

  systemd.tmpfiles.rules = [
    "d /home/main/dconfig/adguard 0755 adguardhome adguardhome -"
  ];

  # --- Systemd Service for recursive chown ---
  systemd.services.adguard-chown-recursive = {
    description = "Recursively chown AdGuard data directory";
    # Ensures this service runs AFTER the directory is created by tmpfiles
    after = ["tmpfiles-setup.service"];
    wantedBy = ["multi-user.target"];

    type = "oneshot";
    remainAfterExit = true;

    # The command to execute - no need for explicit mkdir -p or directory existence check
    # as tmpfiles-setup.service guarantees its creation.
    script = ''
      ${pkgs.coreutils}/bin/chown -R adguardhome:adguardhome /home/${config.vars.user}/dconfig/adguard
    '';
  };
}
