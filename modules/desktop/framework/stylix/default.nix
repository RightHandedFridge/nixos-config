{ lib, config, ... }: {
  options.modules.desktop.framework.stylix = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.modules.desktop.framework.enable;
      description = "Enable Stylix.";
    };
  };

  imports = [
    ./gtk.nix
    ./qt.nix
    ./hm.nix
    ./nixos.nix
  ];
}
