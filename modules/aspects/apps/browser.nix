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
            "clngdbkpkpeebahjckkjfobafhncgmne" # Stylus
            "lnjaiaapbakfhlbjenjkhffcdpoompki" # Catppuccin Web File Icons
            "hlepfoohegkhhmjieoechaddaejaokhf" # Refined GitHub
            "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
            "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
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
            "clngdbkpkpeebahjckkjfobafhncgmne" # Stylus
            "lnjaiaapbakfhlbjenjkhffcdpoompki" # Catppuccin Web File Icons
            "hlepfoohegkhhmjieoechaddaejaokhf" # Refined GitHub
            "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
            "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
          ];
        };
      };
    };
  };
}
