{
  lib,
  config,
  pkgs,
  ...
}: {
  home-manager.users.${config.vars.user} = lib.mkIf config.modules.programs.multimedia.kdenlive.enable {
    home.packages = with pkgs; [
      (kdePackages.kdenlive.overrideAttrs (prevAttrs: {
        nativeBuildInputs =
          (prevAttrs.nativeBuildInputs or []) ++ [makeBinaryWrapper];

        postInstall =
          (prevAttrs.postInstall or "")
          + ''
            wrapProgram $out/bin/kdenlive \
              --prefix LADSPA_PATH : ${rnnoise-plugin}/lib/ladspa
          '';
      }))
    ];
  };
}
