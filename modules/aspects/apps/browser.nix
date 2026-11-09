{ lib, ... }:
{
  den.aspects.app = {
    chromium = {
      homeManager = {
        home.sessionVariables.BROWSER = lib.mkOverride 1002 "chromium";
        programs.chromium = {
          enable = true;
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
      };
    };

    brave = {
      homeManager = {
        home.sessionVariables.BROWSER = lib.mkOverride 1001 "brave";
        programs.brave = {
          enable = true;
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
    };
  };
}
