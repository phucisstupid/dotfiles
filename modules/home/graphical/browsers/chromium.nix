{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.graphical.browsers = {
    chromium.enable = lib.mkEnableOption "chromium";
    brave.enable = lib.mkEnableOption "brave";
  };
  config.programs = {
    chromium = {
      inherit (config.${namespace}.graphical.browsers.chromium) enable;
      extensions = [
        "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBlock Origin Lite
        "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
        "clngdbkpkpeebahjckkjfobafhncgmne" # Stylus
        "pejdijmoenmkgeppbflobdenhhabjlaj" # iCloud Passwords
        "lnjaiaapbakfhlbjenjkhffcdpoompki" # Catppuccin Web File Icons
        "hlepfoohegkhhmjieoechaddaejaokhf" # Refined GitHub
        "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
        "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
        "lodbfhdipoipcjmlebjbgmmgekckhpfb" # Harper
      ];
    };
    brave = {
      inherit (config.${namespace}.graphical.browsers.brave) enable;
      extensions = [
        "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
        "clngdbkpkpeebahjckkjfobafhncgmne" # Stylus
        "pejdijmoenmkgeppbflobdenhhabjlaj" # iCloud Passwords
        "lnjaiaapbakfhlbjenjkhffcdpoompki" # Catppuccin Web File Icons
        "hlepfoohegkhhmjieoechaddaejaokhf" # Refined GitHub
        "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
        "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
        "lodbfhdipoipcjmlebjbgmmgekckhpfb" # Harper
      ];
    };
  };
}
