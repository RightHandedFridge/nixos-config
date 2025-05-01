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
      ".librewolf"
      /*
      ".librewolf/rhf/storage"
      ".librewolf/rhf/extension-store"
      ".librewolf/rhf/extensions"
      */
    ];
    /*
    files = [
      ".librewolf/rhf/cookies.sqlite" # cookies
      ".librewolf/rhf/places.sqlite" # bookmarks/history/more
      ".librewolf/rhf/permissions.sqlite" # pageinfo->permissions
      ".librewolf/rhf/formhistory.sqlite" # form history
      ".librewolf/rhf/storage.sqlite"
      ".librewolf/rhf/extensions.json"
      ".librewolf/rhf/addonStartup.json.lz4"
    ];
    */
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "librewolf.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
      "x-scheme-handler/about" = "librewolf.desktop";
      "x-scheme-handler/unknown" = "librewolf.desktop";
    };
  };

  #Librewolf
  programs.librewolf = {
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
        packages = with inputs.firefox-addons.packages."x86_64-linux"; [
          ublock-origin
          sponsorblock
          istilldontcareaboutcookies
        ];
      };
    };

    languagePacks = [
      "en-GB"
    ];
  };
}
