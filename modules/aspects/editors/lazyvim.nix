{den, ...}: let
  lazyvim = {
    homeManager.programs.lazyvim = {
      enable = true;
      pluginSource = "nixpkgs";
      extras = {
        ai.sidekick.enable = true;
        coding = {
          mini-surround.enable = true;
          yanky.enable = true;
        };
        editor = {
          dial.enable = true;
          inc-rename.enable = true;
        };
        lang.nix.enable = true;
        util.mini-hipatterns.enable = true;
      };
      plugins.colorscheme = ''
        return {
          "LazyVim/LazyVim",
          opts = {
            colorscheme = "catppuccin-mocha",
          },
        }
      '';
    };
  };
in {
  den.aspects.lazyvim.includes = [lazyvim];
}
