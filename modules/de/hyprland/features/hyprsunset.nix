{ ... }:{

  services.hyprsunset = {
    enable = true;
    settings = {
      {
        max-gamma = 150;

        profile = [
          {
            time = "18:30";
            temperature = 3000;
          }
          {
            time = "06:00";
            temperature = 6000;
          }
        ];
      }
    };
  };


}