{ ... }:{
  services.adguardhome = {
  enable = true;
  openFirewall = true;
  port = 280;
  settings = {
    filters = [
      #All filters from Firebog.net
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
      {
        enabled = true;
        url = "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Alternate%20versions%20Anti-Malware%20List/AntiMalwareHosts.txt";
        name = "DandelionSprout Anti-Malware";
      }
      {
        enabled = true;
        url = "https://v.firebog.net/hosts/Prigent-Crypto.txt";
        name = "Prigent-Crypto";
      }
      {
        enabled = true;
        url = "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Risk/hosts";
        name = "FadeMind Risk";
      }
      {
        enabled = true;
        url = "https://bitbucket.org/ethanr/dns-blacklists/raw/8575c9f96e5b4a1308f2f12394abd86d0927a4a0/bad_lists/Mandiant_APT1_Report_Appendix_D.txt";
        name = "Mandiant APT1";
      }
      {
        enabled = true;
        url = "https://phishing.army/download/phishing_army_blocklist_extended.txt";
        name = "Phishing Army";
      }
      {
        enabled = true;
        url = "https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-malware.txt";
        name = "NoTrack Malware";
      }
      {
        enabled = true;
        url = "https://v.firebog.net/hosts/RPiList-Malware.txt";
        name = "RPiList Malware";
      }
      {
        enabled = true;
        url = "https://raw.githubusercontent.com/Spam404/lists/master/main-blacklist.txt";
        name = "Spam404";
      }
      {
        enabled = true;
        url = "https://raw.githubusercontent.com/AssoEchap/stalkerware-indicators/master/generated/hosts";
        name = "Stalkerware Indicators";
      }
      {
        enabled = true;
        url = "https://urlhaus.abuse.ch/downloads/hostfile/";
        name = "URLHaus";
      }
      {
        enabled = true;
        url = "https://lists.cyberhost.uk/malware.txt";
        name = "CyberHost Malware";
      }
    ];
  };
};

  networking.firewall.allowedTCPPorts = [ 280 53 ];
}