{ lib, ... }:{
  options.programs.browser.tor.enable = {
    enable = lib.mkEnableOption "Enable Tor Browser";
  };

  imports = [
    ./hm.nix
  ];
}