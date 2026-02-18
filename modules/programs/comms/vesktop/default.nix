{lib, ...}: {
  options.modules.programs.comms.vesktop = {
    enable = lib.mkEnableOption "Enable Vesktop";
  };

  imports = [
    ./hm.nix
  ];
}
