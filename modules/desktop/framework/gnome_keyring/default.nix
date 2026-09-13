{ lib, config, ... }: {
  options.modules.desktop.framework.gnome-keyring = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.modules.desktop.framework.enable;
      description = "Enable GNOME Keyring.";
    };
  };

  imports = [
    ./nixos.nix
  ];
}
