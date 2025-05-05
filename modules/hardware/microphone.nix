{pkgs, ...}: {
  #This is a home manager module
  home.packages = with pkgs; [
    easyeffects
  ];

  home.file = {
    ".config/easyeffects/input/lpxw.json".text = ''
          {
          "input": {
              "blocklist": [],
              "plugins_order": [
                  "speex#0"
              ],
              "speex#0": {
                  "bypass": false,
                  "enable-agc": false,
                  "enable-denoise": true,
                  "enable-dereverb": false,
                  "input-gain": 0.0,
                  "noise-suppression": -70,
                  "output-gain": 5.5,
                  "vad": {
                      "enable": true,
                      "probability-continue": 90,
                      "probability-start": 85
                  }
              }
          }
      }
    '';
  };
}
