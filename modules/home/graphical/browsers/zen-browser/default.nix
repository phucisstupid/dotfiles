{
  config,
  lib,
  flake,
  ...
}:
{
  options.${flake.config.me.namespace}.graphical.browsers.zen-browser.enable =
    lib.mkEnableOption "zen-browser";
  config = lib.mkIf config.${flake.config.me.namespace}.graphical.browsers.zen-browser.enable {
    programs.zen-browser = {
      enable = true;
      policies = {
        AutofillAddressEnabled = true;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
      };
    };
  };
}
