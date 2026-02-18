{lib, ...}: {
  options.modules.programs.comms.element = {
    enable = lib.mkEnableOption "Enable Element";
  };

  imports = [
    ./nixos.nix
  ];
}
