{pkgs, ...}: {
  services.printing = {
    enable = true;
    drivers = [pkgs.foo2zjs];
  };
}
