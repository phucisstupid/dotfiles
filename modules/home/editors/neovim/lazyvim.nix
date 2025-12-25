{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.editors.neovim.lazyvim.enable = lib.mkEnableOption "neovim.lazyvim";
  config.programs.lazyvim = lib.mkMerge [
    {
      inherit (config.${namespace}.editors.neovim.lazyvim) enable;
      extras = {
        ai.copilot.enable = true;
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
              colorscheme = "catppuccin",
            },
          }
        '';
      };
    }
  ];
}
