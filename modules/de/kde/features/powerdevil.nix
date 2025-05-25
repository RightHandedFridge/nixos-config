{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.modules.de.kde.enable {
    home.file.".config/powerdevilrc".text = ''
      [AC][Display]
      DimDisplayIdleTimeoutSec=-1
      DimDisplayWhenIdle=false

      [AC][Performance]
      PowerProfile=balanced

      [AC][SuspendAndShutdown]
      AutoSuspendAction=0
      LidAction=1
      SleepMode=3

      [Battery][Display]
      DimDisplayIdleTimeoutSec=300
      DimDisplayWhenIdle=true

      [Battery][Performance]
      PowerProfile=power-saver

      [Battery][SuspendAndShutdown]
      AutoSuspendAction=1
      AutoSuspendIdleTimeoutSec=600
      LidAction=2

      [BatteryManagement]
      BatteryCriticalAction=2

      [LowBattery][Display]
      DisplayBrightness=20

      [LowBattery][Performance]
      PowerProfile=power-saver

      [LowBattery][SuspendAndShutdown]
      LidAction=2
      SleepMode=3
    '';
  };
}
