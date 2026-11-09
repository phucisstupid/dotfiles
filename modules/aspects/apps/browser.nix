_: {
  den.aspects.app = {
    default = {
      chromium.homeManager.home.sessionVariables.BROWSER = "chromium";
      brave.homeManager.home.sessionVariables.BROWSER = "brave";
    };

    chromium = {
      default.homeManager.home.sessionVariables.BROWSER = "chromium";
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
      default.homeManager.home.sessionVariables.BROWSER = "brave";
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
