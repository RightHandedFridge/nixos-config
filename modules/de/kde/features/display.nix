{
  lib,
  osConfig,
  config,
  ...
}: {
  config = lib.mkIf osConfig.modules.de.kde.enable {
    home.file.".config/kwinoutputconfig.json" = {
      force = true;
      source = ../../../../dotfiles/kde/${config.vars.host}-display.json;
    };

    home.file.".config/kwinrc" = {
      force = true;
      text = ''
        [Activities][LastVirtualDesktop]
        23657797-4f58-4049-bc7d-cf890ebcbf5b=Desktop_1

        [Desktops]
        Id_1=Desktop_1
        Id_2=Desktop_2
        Id_3=Desktop_3
        Id_4=Desktop_4
        Id_5=Desktop_5
        Id_6=Desktop_6
        Id_7=Desktop_7
        Id_8=Desktop_8
        Name_1=Browser
        Name_2=Left
        Name_3=Right
        Name_4=Comms
        Name_5=Music
        Name_6=Six
        Name_7=Seven
        Name_8=Eight
        Number=8
        Rows=1

        [NightColor]
        Active=true
        EveningBeginFixed=1830
        Mode=Times
        MorningBeginFixed=0500
        NightTemperature=1500

        [Plugins]
        poloniumEnabled=true

        [Script-polonium]
        EngineType=0
        InsertionPoint=1
        MaximizeSingle=true
        TilePopups=false

        [Tiling]
        padding=4

        [Tiling][f824ba79-54f9-5e18-9654-368eee7cd8f1]
        tiles={"layoutDirection":"horizontal","tiles":[{"width":0.5},{"width":0.5}]}

        [Xwayland]
        Scale=1

        [org.kde.kdecoration2]
        ButtonsOnRight=IAX
      '';
    };
  };
}
