{ lib, config, ... }: {
  options.modules.programs.browser.tor = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.modules.programs.browser.enable;
      description = "Enable Tor Browser.";
    };
  };

  imports = [
    ./hm.nix
  ];
}
