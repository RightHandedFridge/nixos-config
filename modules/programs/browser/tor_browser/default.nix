{ lib, ... }: {
  options.modules.programs.browser.tor = {
    enable = lib.mkEnableOption "Enable Tor Browser";
  };

  imports = [
    ./hm.nix
  ];
}
