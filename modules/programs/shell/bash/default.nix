{lib, ...}: {
  options.modules.programs.shell.bash = {
    enable = lib.mkEnableOption "Enable Bash";
  };

  imports = [
    ./nixos.nix
    ./hm.nix
  ];
}
