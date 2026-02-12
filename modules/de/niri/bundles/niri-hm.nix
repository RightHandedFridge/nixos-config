{ pkgs
, inputs
, osConfig
, lib
, ...
}: {
  imports = [
    ../features/niri.nix
    ../../shells/noctalia/noctalia-hm.nix
  ];
  config =
    lib.mkIf osConfig.modules.de.niri.enable { };
}
