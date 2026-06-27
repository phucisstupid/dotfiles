{
  pkgs,
  flake,
  ...
}: let
  inherit (flake) inputs;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  den.aspects.apps.spotify = {
    homeManager = {
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
