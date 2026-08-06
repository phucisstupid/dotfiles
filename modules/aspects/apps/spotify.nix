{
  den,
  inputs,
  ...
}: {
  flake-file.inputs.spicetify-nix = {
    url = "github:Gerg-L/spicetify-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.app.spotify = {
    includes = [(den.batteries.unfree ["spotify"])];

    homeManager = {pkgs, ...}: let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
    in {
      imports = [inputs.spicetify-nix.homeManagerModules.spicetify];
      programs.spicetify = {
        enable = true;
        theme = spicePkgs.themes.catppuccin;
        colorScheme = "mocha";
        enabledExtensions = with spicePkgs.extensions; [
          adblock
          keyboardShortcut
        ];
        enabledCustomApps = with spicePkgs.apps; [lyricsPlus];
      };
    };
  };
}
