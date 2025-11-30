#Fixes issue where window pops-up when a new device is connected
# TODO: Remove this once Solaar 1.1.17 is released
self: super: {
  solaar = super.solaar.overridePythonAttrs (old: {
    patches =
      (old.patches or [])
      ++ [
        (super.fetchpatch {
          url = "https://github.com/pwr-Solaar/Solaar/pull/3000.patch";
          hash = "sha256-zI0U3llouWrwo4z2Rien4rXjtmnppF2azCqawAol+zM=";
        })
      ];
  });
}
