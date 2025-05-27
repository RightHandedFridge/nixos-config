{...}: {
  home.file = {
    ".config/plasmashellrc" = {
      force = true;
      text = ''
        [PlasmaViews][Panel 2]
        alignment=2
        floating=1
        panelLengthMode=1
        panelVisibility=1

        [PlasmaViews][Panel 2][Defaults]
        thickness=40

        [Updates]
        performed=/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/containmentactions_middlebutton.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/digitalclock_migrate_font_settings.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/digitalclock_migrate_showseconds_setting.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/digitalclock_rename_timezonedisplay_key.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/folderview_fix_recursive_screenmapping.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/keyboardlayout_migrateiconsetting.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/keyboardlayout_remove_shortcut.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/klipper_clear_config.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/maintain_existing_desktop_icon_sizes.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/mediaframe_migrate_useBackground_setting.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/migrate_font_weights.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/move_desktop_layout_config.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/no_middle_click_paste_on_panels.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/systemloadviewer_systemmonitor.js,/run/current-system/sw/share/plasma/shells/org.kde.plasma.desktop/contents/updates/unlock_widgets.js
      '';
    };

    ".config/plasma-org.kde.plasma.desktop-appletsrc" = {
      force = true;
      text = ''
        [ActionPlugins][0]
        RightButton;NoModifier=org.kde.contextmenu

        [ActionPlugins][1]
        RightButton;NoModifier=org.kde.contextmenu

        [Containments][1]
        ItemGeometriesHorizontal=
        activityId=0cecdff2-99b9-4772-a0ee-974cac53a96d
        formfactor=0
        immutability=1
        lastScreen=0
        location=0
        plugin=org.kde.plasma.folder
        wallpaperplugin=org.kde.image

        [Containments][1][General]
        positions={"1920x1080":[]}

        [Containments][2]
        activityId=
        formfactor=2
        immutability=1
        lastScreen=0
        location=3
        plugin=org.kde.panel
        wallpaperplugin=org.kde.image

        [Containments][2][Applets][18]
        immutability=1
        plugin=org.kde.plasma.digitalclock

        [Containments][2][Applets][18][Configuration]
        popupHeight=375
        popupWidth=525

        [Containments][2][Applets][18][Configuration][Appearance]
        fontWeight=400

        [Containments][2][Applets][7]
        immutability=1
        plugin=org.kde.plasma.systemtray

        [Containments][2][Applets][7][Configuration]
        PreloadWeight=55
        SystrayContainmentId=8

        [Containments][2][General]
        AppletOrder=7;18

        [Containments][8]
        activityId=
        formfactor=2
        immutability=1
        lastScreen=-1
        location=3
        plugin=org.kde.plasma.private.systemtray
        popupHeight=432
        popupWidth=432
        wallpaperplugin=org.kde.image

        [Containments][8][Applets][10]
        immutability=1
        plugin=org.kde.plasma.clipboard

        [Containments][8][Applets][11]
        immutability=1
        plugin=org.kde.plasma.devicenotifier

        [Containments][8][Applets][12]
        immutability=1
        plugin=org.kde.plasma.manage-inputmethod

        [Containments][8][Applets][13]
        immutability=1
        plugin=org.kde.plasma.notifications

        [Containments][8][Applets][13][Configuration]
        PreloadWeight=55

        [Containments][8][Applets][14]
        immutability=1
        plugin=org.kde.kscreen

        [Containments][8][Applets][15]
        immutability=1
        plugin=org.kde.plasma.keyboardindicator

        [Containments][8][Applets][16]
        immutability=1
        plugin=org.kde.plasma.keyboardlayout

        [Containments][8][Applets][17]
        immutability=1
        plugin=org.kde.plasma.volume

        [Containments][8][Applets][17][Configuration][General]
        migrated=true

        [Containments][8][Applets][20]
        immutability=1
        plugin=org.kde.plasma.networkmanagement

        [Containments][8][Applets][21]
        immutability=1
        plugin=org.kde.plasma.bluetooth

        [Containments][8][Applets][22]
        immutability=1
        plugin=org.kde.plasma.brightness

        [Containments][8][Applets][23]
        immutability=1
        plugin=org.kde.plasma.battery

        [Containments][8][Applets][9]
        immutability=1
        plugin=org.kde.plasma.cameraindicator

        [Containments][8][General]
        extraItems=org.kde.plasma.cameraindicator,org.kde.plasma.clipboard,org.kde.plasma.devicenotifier,org.kde.plasma.manage-inputmethod,org.kde.plasma.mediacontroller,org.kde.plasma.notifications,org.kde.kscreen,org.kde.plasma.battery,org.kde.plasma.bluetooth,org.kde.plasma.brightness,org.kde.plasma.keyboardindicator,org.kde.plasma.keyboardlayout,org.kde.plasma.networkmanagement,org.kde.plasma.volume
        knownItems=org.kde.plasma.cameraindicator,org.kde.plasma.clipboard,org.kde.plasma.devicenotifier,org.kde.plasma.manage-inputmethod,org.kde.plasma.mediacontroller,org.kde.plasma.notifications,org.kde.kscreen,org.kde.plasma.battery,org.kde.plasma.bluetooth,org.kde.plasma.brightness,org.kde.plasma.keyboardindicator,org.kde.plasma.keyboardlayout,org.kde.plasma.networkmanagement,org.kde.plasma.volume

        [ScreenMapping]
        itemsOnDisabledScreens=
        screenMapping=
      '';
    };
  };
}
