{
  system = {
    primaryUser = "kosudanaohiro";
    stateVersion = 5;
    defaults = {
      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
      NSGlobalDomain = {
        InitialKeyRepeat = 10;
        KeyRepeat = 1;

        AppleShowAllExtensions = true;
        AppleKeyboardUIMode = 3;
        AppleInterfaceStyle = "Dark";

        _HIHideMenuBar = true;

        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;
      };
      finder = {
        AppleShowAllFiles = true;
        AppleShowAllExtensions = true;
      };
      dock = {
        autohide = true;
        mru-spaces = false;
        show-recents = false;
      };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };
  time.timeZone = "Asia/Tokyo";
}
