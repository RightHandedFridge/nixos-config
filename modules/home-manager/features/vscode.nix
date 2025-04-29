{
  config,
  pkgs,
  ...
}: {
  home.persistence."/persist/home/${config.vars.user}" = config.modules.impermanence.enable {
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
