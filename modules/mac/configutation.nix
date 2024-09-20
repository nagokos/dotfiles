{
  system.defaults = {
    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
    NSGlobalDomain = {
      InitialKeyRepeat = 10;
      KeyRepeat = 1;
      AppleInterfaceStyle = "Dark";
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticWindowAnimationsEnabled = false;
    };
    dock = {
      autohide = true;
      mru-spaces = false;
      show-recents = false;
    };
  };
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };
  system.stateVersion = 5;
  time.timeZone = "Asia/Tokyo";
  services.nix-daemon.enable = true;
}
