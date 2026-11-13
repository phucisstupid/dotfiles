{ den, inputs, ... }:
let
  chromiumDefault = {
    includes = [ den.aspects.app.chromium ];
    homeManager =
      { config, lib, ... }:
      lib.mkIf config.programs.chromium.enable {
        home.sessionVariables.BROWSER = "chromium";
      };
  };
  heliumDefault = {
    includes = [ den.aspects.app.helium ];
    homeManager.home.sessionVariables.BROWSER = "helium";
  };
in
{
  # TODO: Remove this input once nixpkgs packages Helium for both hosts.
  flake-file.inputs.helium = {
    url = "github:schembriaiden/helium-browser-nix-flake";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.app = {
    default = {
      chromium = chromiumDefault;
      helium = heliumDefault;
    };

    chromium = {
      default = chromiumDefault;
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

    helium = {
      default = heliumDefault;
      homeManager =
        {
          config,
          lib,
          pkgs,
          ...
        }:
        let
          extensionDir =
            if pkgs.stdenv.hostPlatform.isDarwin then
              "Library/Application Support/net.imput.helium/External Extensions"
            else
              "${config.xdg.configHome}/net.imput.helium/External Extensions";
          extensions = [
            "nngceckbapebfimnlniiiahkandclblb" # Bitwarden Password Manager
            "lnjaiaapbakfhlbjenjkhffcdpoompki" # Catppuccin Web File Icons
            "hlepfoohegkhhmjieoechaddaejaokhf" # Refined GitHub
            "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
            "clngdbkpkpeebahjckkjfobafhncgmne" # Stylus
            "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
          ];
        in
        {
          home.packages = [ inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default ];
          home.file = lib.listToAttrs (
            map (id: {
              name = "${extensionDir}/${id}.json";
              value.text = builtins.toJSON {
                # Helium resolves this URL through its extension download service.
                external_update_url = "https://update-url-to-be-replaced.qjz9zk";
              };
            }) extensions
          );
        };
    };
  };
}
