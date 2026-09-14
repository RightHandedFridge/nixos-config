{
  pkgs,
  config,
  lib,
  ...
}: {
  home-manager.users.${config.vars.user} = lib.mkIf config.modules.programs.editors.helix.enable {
    programs.helix = {
      enable = true;
      defaultEditor = true;
      settings = {
        editor = {
          line-number = "relative";
          mouse = false;
          auto-save = {
            focus-lost = true;
            after-delay = {
              enable = true;
              timeout = 3000;
            };
          };
        };
      };
      languages = {
        language = [
          {
            name = "nix";
            auto-format = true;
            formatter = {
              command = "alejandra";
            };
            language-servers = ["nil"];
          }
        ];
      };
      extraPackages = with pkgs; [
        nil
        alejandra
      ];
    };
  };
}
