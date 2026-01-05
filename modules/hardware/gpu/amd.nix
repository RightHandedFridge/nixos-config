{...}: {
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  nixpkgs.config = {
    rocmSupport = true;
  };
}
