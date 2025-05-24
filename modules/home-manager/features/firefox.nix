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
        ''
        user_pref("browser.shell.checkDefaultBrowser", false);
        user_pref("extensions.pocket.enabled", false);
        user_pref("privacy.sanitize.sanitizeOnShutdown", false);
        user_pref("widget.use-xdg-desktop-portal.file-picker", 1);
        ''
      ];
    };

    languagePacks = [
      "en-GB"
    ];
  };
}
