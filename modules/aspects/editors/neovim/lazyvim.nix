{inputs, ...}: {
  flake-file.inputs.lazyvim-nix = {
    url = "github:pfassina/lazyvim-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.editor.neovim.lazyvim = {
    homeManager = {
      imports = [inputs.lazyvim-nix.homeManagerModules.default];

      programs.neovim = {
        defaultEditor = true;
        viAlias = true;
      };

      programs.lazyvim = {
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
          lang = {
            nix.enable = true;
          };
          util.mini-hipatterns.enable = true;
        };
        plugins = {
          colorscheme = ''
            return {
              "LazyVim/LazyVim",
              opts = {
                colorscheme = "catppuccin-mocha",
              },
            }
          '';
        };
      };
    };
  };
}
