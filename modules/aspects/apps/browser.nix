_: {
  den.aspects.app = {
    chromium = {
      homeManager = {
        home.sessionVariables.BROWSER = "chromium";
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
        home.sessionVariables.BROWSER = "brave";
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
