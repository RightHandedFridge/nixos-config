{pkgs, ...}: {
  home.packages = with pkgs; [
    clematis
    kdePackages.elisa
  ];

  home.file = {
    ".config/Clematis/config.json" = {
      text = ''
        {
          "whitelist": ["Elisa"]
          "presence": {
          "details": "{title}" // the top text in the presence
          "state": "{artist} {album}", // the bottom text in the presence
         },
        }
      '';
    };
  };
}
