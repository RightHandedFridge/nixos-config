{ lib
, osConfig
, ...
}: {
  config = lib.mkIf osConfig.modules.de.hyprland.enable {
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          hide_cursor = true;
          ignore_empty_input = true;
          no_fade_in = false;
          grace = 0;
          disable_loading_bar = false;
        };

        background = {
          blur_passes = 2;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        };

        input_field = {
          size = "250, 60";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(100, 114, 125, 0.4)";
          font_color = "rgb(200, 200, 200)";
          fade_on_empty = false;
          font_family = "Inter";
          placeholder_text = ''<i><span foreground="##ffffff99">Enter Password</span></i>'';
          hide_input = false;
          position = "0, -225";
          halign = "center";
          valign = "center";
        };

        label = [
          # Time
          {
            text = ''cmd[update:1000] echo "<span>$(date +"%H:%M")</span>"'';
            color = "rgba(216, 222, 233, 0.70)";
            font_size = 130;
            font_family = "Inter";
            position = "0, 240";
            halign = "center";
            valign = "center";
          }

          # Day-Month-Date
          {
            text = ''cmd[update:1000] echo -e "$(date +"%A, %d %B")"'';
            color = "rgba(216, 222, 233, 0.70)";
            font_size = 30;
            font_family = "Inter";
            position = "0, 105";
            halign = "center";
            valign = "center";
          }
        ];
      };
    };
  };
}
