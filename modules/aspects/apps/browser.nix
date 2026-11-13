{ den, ... }:
let
  mkDefault = name: {
    includes = [ den.aspects.app.${name} ];
    homeManager =
      { config, lib, ... }:
      lib.mkIf config.programs.${name}.enable {
        home.sessionVariables.BROWSER = name;
      };
  };
in
{
  den.aspects.app = {
    default = {
      chromium = mkDefault "chromium";
      brave = mkDefault "brave";
    };

    chromium = {
      default = mkDefault "chromium";
      homeManager =
        { lib, pkgs, ... }:
        lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
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
      default = mkDefault "brave";
      homeManager =
        { lib, pkgs, ... }:
        lib.mkIf (lib.meta.availableOn pkgs.stdenv.hostPlatform pkgs.brave) {
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
