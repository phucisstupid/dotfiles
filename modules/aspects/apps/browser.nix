_: {
  den.aspects.app.browser = {
    chromium = {
      homeManager = {
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
