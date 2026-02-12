{ config, lib, pkgs, ... }: {
  config = lib.mkIf config.modules.programs.filemanager.nautilus.enable {
    environment.systemPackages = with pkgs; [
      nautilus
      libheif
      libheif.out
    ];

    environment.pathsToLink = [ "share/thumbnailers" ];

    services.gvfs.enable = true; #Fix Trash not showing up
    services.udisks2.enable = true; #Automount USB Devices

    #Fix audio/video properties menu
    nixpkgs.overlays = [
      (final: prev: {
        nautilus = prev.nautilus.overrideAttrs (nprev: {
          buildInputs =
            nprev.buildInputs
            ++ (with pkgs.gst_all_1; [
              gst-plugins-good
              gst-plugins-bad
            ]);
        });
      })
    ];
  };
}
