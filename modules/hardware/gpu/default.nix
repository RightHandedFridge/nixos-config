{ lib, ... }: {
  options.modules.hardware = {
    gpu = {
      amd = {
        enable = lib.mkEnableOption "Enable AMD GPU support";
      };
      nvidia = {
        enable = lib.mkEnableOption "Enable NVIDIA GPU support";
      };
    };
  };

  imports = [
    ./amd.nix
    ./nvidia.nix
  ];
}
