{inputs, ...}: {
  den.aspects.app.spotify = {
    homeManager = {pkgs, ...}: let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
    in {
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
