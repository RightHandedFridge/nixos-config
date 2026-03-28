{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: {
  home-manager.users.${config.vars.user} = lib.mkIf config.modules.hardware.microphone.enable {
    home.packages = with pkgs; [
      rnnoise-plugin
    ];
    services.easyeffects = {
      enable = true;
      preset = "mic";
      extraPresets = {
        mic = {
          input = {
            blocklist = [
            ];

            plugins_order = [
              "gate#0"
              "rnnoise#0"
              "stereo_tools#0"
            ];

            "gate#0" = {
              bypass = false;
              attack = 5.0;
              release = 120.0;
              threshold = -40.0; # slightly more aggressive
              ratio = 10.0;
            };

            "rnnoise#0" = {
              bypass = false;
              input-gain = 2.0; # small boost for voice
              output-gain = 0.0;
              vad-thres = 50.0;
              wet = 1.0; # max suppression
              enable-vad = true;
              "use-standard-model" = true;
              "model-name" = "\"\"";
              release = 20.0;
            };

            "stereo_tools#0" = {
              bypass = false;
              mode = "LR > L+R (Mono Sum L+R)";
              "balance-in" = 0.0;
              "balance-out" = 0.0;
              delay = 0.0;
              "input-gain" = 0.0;
              "output-gain" = 0.0;
            };
          };
        };
      };
    };
  };
}
