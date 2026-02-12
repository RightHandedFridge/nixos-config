{ lib, ... }: {
  options.modules.programs.browser.firefox = {
    enable = lib.mkEnableOption "Enable Firefox browser";
  };

  imports = [
    ./hm.nix
  ];
}
