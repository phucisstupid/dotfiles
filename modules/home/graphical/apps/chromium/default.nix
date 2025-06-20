{
  config,
  lib,
  flake,
  ...
}:
let
  inherit (flake.config.me) namespace;
in
{
  options.${namespace}.graphical.apps.chromium = {
    default.enable = lib.mkEnableOption "chromium";
    brave.enable = lib.mkEnableOption "brave";
  };
  config.programs = lib.mkMerge [
    (lib.mkIf config.${namespace}.graphical.apps.chromium.default.enable {
      chromium = {
        enable = true;
        extensions = [
          "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBlock Origin Lite
          "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
          "clngdbkpkpeebahjckkjfobafhncgmne" # Stylus
          "pejdijmoenmkgeppbflobdenhhabjlaj" # iCloud Passwords
          "lnjaiaapbakfhlbjenjkhffcdpoompki" # Catppuccin Web File Icons
          "hlepfoohegkhhmjieoechaddaejaokhf" # Refined GitHub
          "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
          "hfjbmagddngcpeloejdejnfgbamkjaeg" # Vimium C
        ];
      };
    })
    (lib.mkIf config.${namespace}.graphical.apps.chromium.brave.enable {
      brave = {
        enable = true;
        extensions = [
          "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
          "clngdbkpkpeebahjckkjfobafhncgmne" # Stylus
          "pejdijmoenmkgeppbflobdenhhabjlaj" # iCloud Passwords
          "lnjaiaapbakfhlbjenjkhffcdpoompki" # Catppuccin Web File Icons
          "hlepfoohegkhhmjieoechaddaejaokhf" # Refined GitHub
          "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
          "hfjbmagddngcpeloejdejnfgbamkjaeg" # Vimium C
        ];
      };
    })
  ];
}
