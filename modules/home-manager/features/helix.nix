{pkgs, ...}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      editor = {
        line-number = "relative";
        mouse = false;
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
}
