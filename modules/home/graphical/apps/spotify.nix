{
  config,
  pkgs,
  lib,
  flake,
  ...
}: let
  inherit (flake) inputs;
  inherit (flake.config.me) namespace;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  options.${namespace}.graphical.apps.spotify.enable = lib.mkEnableOption "spotify";
  config = lib.mkIf config.${namespace}.graphical.apps.spotify.enable {
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
}
