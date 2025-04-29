{
  config,
  pkgs,
  lib,
  osConfig,
  ...
}: {
  home.persistence."/persist/home/${config.vars.user}" = lib.mkIf osConfig.modules.system.impermanence.enable {
    directories = [
      ".config/Code/" #Persist user session files so things stay open
    ];
  };
  
  #VSCode
  programs.vscode.profiles.default = {
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
            "command" = ["alejandra"];
          };
        };
      };
    };
  };
}
