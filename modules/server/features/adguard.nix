{
  services.adguardhome = {
    enable = true;
    openFirewall = false;
    port = 280;
    settings = {
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
    allowedTCPPorts = [ 53 ];
    allowedUDPPorts = [ 53 ];
  };
}
