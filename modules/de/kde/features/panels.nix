{...}: {
  home.file.".config/plasmashellrc" = {
    force = true;
    text = ''
      [PlasmaTransientsConfig]
      PreloadWeight=0

      [PlasmaViews][Panel 2]
      floating=1

      [PlasmaViews][Panel 2][Defaults]
      thickness=40

      [PlasmaViews][Panel 24]
      alignment=2
      floating=1
      panelLengthMode=1
      panelVisibility=1

      [PlasmaViews][Panel 24][Defaults]
      thickness=44
    '';
  };
}
