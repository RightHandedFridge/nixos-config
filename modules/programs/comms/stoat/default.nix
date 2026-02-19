{lib, ...}: {
  options.modules.programs.comms.stoat = {
    enable = lib.mkEnableOption "Enable Stoat (formerly Revolt)";
  };

  imports = [
    ./nixos.nix
  ];
}
