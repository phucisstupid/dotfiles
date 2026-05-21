# Optional desktop app aspects.
{
  den,
  inputs,
  ...
}: let
  perUser = homeManager: den.lib.perUser {inherit homeManager;};
in {
  den.aspects.kodi.includes = [
    (perUser {
      programs.kodi.enable = true;
    })
  ];

  den.aspects.obs-studio.includes = [
    (den.lib.perUser {
      homeManager = {pkgs, ...}: {
        programs.obs-studio = {
          enable = true;
          plugins = with pkgs.obs-studio-plugins; [
            droidcam-obs
          ];
        };
      };
    })
  ];

  den.aspects.spotify.includes = [
    (den.lib.perUser {
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
    })
  ];

  den.aspects.zathura.includes = [
    (perUser {
      programs.zathura.enable = true;
    })
  ];
}
