# Optional browser aspects.
{den, ...}: let
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
  perUser = homeManager: den.lib.perUser {inherit homeManager;};
in {
  den.aspects.chromium.includes = [
    (perUser {
      programs.chromium = {
        enable = true;
        extensions =
          ["ddkjiahejlhfcafbddmgiahcphecmpfh"]
          ++ extensions;
      };
    })
  ];

  den.aspects.brave.includes = [
    (perUser {
      programs.brave = {
        enable = true;
        inherit extensions;
      };
    })
  ];

  den.aspects.qutebrowser.includes = [
    (perUser {
      programs.qutebrowser = {
        enable = true;
        settings = {
          window.hide_decoration = true;
          fonts.default_family = "Maple Mono NF";
        };
      };
    })
  ];
}
