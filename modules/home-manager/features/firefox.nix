{
  config,
  inputs,
  osConfig,
  lib,
  pkgs,
  ...
}: {
  home.persistence."/persist/home/${config.vars.user}" = lib.mkIf osConfig.modules.system.impermanence.enable {
    directories = [
      ".mozilla/firefox/rhf/"
    ];
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };
  };

  
  programs.firefox = {
    profiles.rhf = {
      name = "rhf";
      search = {
        force = true;
        default = "StartPage";
        privateDefault = "StartPage";
        engines = {
          "StartPage" = {
            urls = [{template = "https://www.startpage.com/search?q={searchTerms}";}];
            icon = "https://www.startpage.com/favicon.ico";
          };

          "nixpkgs" = {
            urls = [{template = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={searchTerms}";}];
            icon = "https://nixos.org/favicon.ico";
          };
          "bing".metaData.hidden = true;
        };
      };

      settings = {
        #Set Default Theme to Dark
        "layout.css.prefers-color-scheme.content-override" = 0;
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "intl.regional_prefs.use_os_locales" = true;
        "places.history.enabled" = false;
        "network.trr.mode" = 0;
        "privacy.resistFingerprinting.autoDeclineNoUserInputCanvasPrompts" = true;
        "privacy.sanitize.sanitizeOnShutdown" = false;
        "browser.contentblocking.category" = "custom";
      };
      extensions = {
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          sponsorblock
          istilldontcareaboutcookies
          youtube-recommended-videos #unhook
        ];
      };

      extraConfig = lib.strings.concatStrings [
        (builtins.readFile "${inputs.arkenfox}/user.js")
      ];
    };

    languagePacks = [
      "en-GB"
    ];
  };
}
