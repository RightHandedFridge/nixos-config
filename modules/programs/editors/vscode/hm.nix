{ config
, pkgs
, lib
, osConfig
, ...
}: {
  home-manager.users.${config.vars.user} = lib.mkIf config.modules.programs.editors.vscode.enable {
    #VSCode
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
      profiles.default = {
        enableExtensionUpdateCheck = true;
        enableUpdateCheck = true;
        extensions = with pkgs; [
          vscode-extensions.jnoortheen.nix-ide
          vscode-extensions.redhat.java
        ];
        userSettings = {
          "files.autosave" = "off";
          "nix.serverPath" = "nixd";
          "nix.enableLanguageServer" = true;
          "nix.serverSettings" = {
            "nixd" = {
              "formatting" = {
                "command" = [ "alejandra" ];
              };
            };
          };
        };
      };
    };
  };
}
