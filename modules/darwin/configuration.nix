{ pkgs, ... }:
{
  # essential macOs settings
  system.defaults = {
    CustomUserPreferences."com.apple.AdLib".allowApplePersonalizedAdvertising = false;
    LaunchServices.LSQuarantine = false;
    controlcenter.BatteryShowPercentage = true;
    ".GlobalPreferences"."com.apple.mouse.scaling" = 3.0;
    trackpad = {
      Clicking = true;
      ActuationStrength = 0;
      TrackpadThreeFingerDrag = true;
    };
    loginwindow = {
      GuestEnabled = false;
      DisableConsoleAccess = true;
    };
    dock = {
      expose-group-apps = true;
      tilesize = 40;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.0;
      largesize = 80;
      mru-spaces = false;
      show-recents = false;
      magnification = true;
      showhidden = true;
      autohide = true;
      static-only = true;
    };
    finder = {
      FXPreferredViewStyle = "clmv";
      FXDefaultSearchScope = "SCcf";
      _FXSortFoldersFirst = true;
      AppleShowAllFiles = true;
      AppleShowAllExtensions = true;
      NewWindowTarget = "Home";
      CreateDesktop = false;
      ShowStatusBar = true;
      ShowPathbar = true;
      FXRemoveOldTrashItems = true;
    };
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      NSWindowShouldDragOnGesture = true;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      _HIHideMenuBar = true;
      "com.apple.trackpad.scaling" = 3.0;
      "com.apple.swipescrolldirection" = false;
    };
  };
  networking = {
    knownNetworkServices = [
      "Wi-Fi"
      "Ethernet"
    ];
    dns = [
      "1.1.1.1"
      "1.0.0.1"
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
    ];
  };
  # default shell
  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];
  services.karabiner-elements = {
    enable = true;
    package = pkgs.karabiner-elements.overrideAttrs (old: {
      version = "14.13.0";
      src = pkgs.fetchurl {
        inherit (old.src) url;
        hash = "sha256-gmJwoht/Tfm5qMecmq1N6PSAIfWOqsvuHU8VDJY8bLw=";
      };
      dontFixup = true;
    });
  };
}
