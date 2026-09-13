{ lib, config, ... }: {
  options.modules.programs.terminal.alacritty = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.modules.programs.terminal.enable;
      description = "Enable Alacritty terminal emulator.";
    };
  };

  imports = [
    ./hm.nix
    ./nixos.nix
  ];
}
