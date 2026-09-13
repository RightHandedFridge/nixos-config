{ lib, config, ... }: {
  options.modules.programs.shell.bash = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.modules.programs.shell.enable;
      description = "Enable Bash.";
    };
  };

  imports = [
    ./nixos.nix
    ./hm.nix
  ];
}
