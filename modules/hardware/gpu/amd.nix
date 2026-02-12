{ pkgs, ... }: {
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  nixpkgs.overlays = [
    (final: prev: {
      btop = prev.btop.override {
        rocmSupport = true;
      };
    })
  ];
}
