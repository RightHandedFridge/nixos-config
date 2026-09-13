{ lib, config, ... }: {
  options.modules.programs.browser.firefox = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.modules.programs.browser.enable;
      description = "Enable Firefox browser.";
    };
  };

  imports = [
    ./hm.nix
  ];
}
