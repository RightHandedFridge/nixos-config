{ config, pkgs, lib, ... }:
{
  programs.helix = {
    enable = true;

    # Base package
    package = pkgs.helix;

    # Make hx the default editor
    defaultEditor = true;

    # General settings
    settings = {
      editor = {
        "line-number" = "relative";
        "lsp.display-messages" = true;  # show syntax errors, warnings, etc
      };
    };

    languages = {
      language-server.rust-analyzer = {
        command = "${pkgs.rust-analyzer}/bin/rust-analyzer";
        args = [];
      };
      language-server.clangd = {
        command = "${pkgs.clang-tools}/bin/clangd";
        args = [];
      };
      language-server.omnisharp = {
        command = "${pkgs.omnisharp-roslyn}/bin/omnisharp";
        args = [];
      };
      language-server.jdtls = {
        command = "${pkgs.jdt-language-server}/bin/jdtls";
        args = [];
      };

      language = [
        { name = "rust"; auto-format = true; }
        { name = "c"; auto-format = true; }
        { name = "cpp"; auto-format = true; }
        { name = "csharp"; auto-format = true; }
        { name = "nix"; auto-format = true; }
        { name = "java"; auto-format = true; }  # Added Java
      ];
    };
  };
}

