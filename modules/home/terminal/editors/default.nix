{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.terminal.editors = {
    neovim = {
      lazyvim.enable = lib.mkEnableOption "neovim.lazyvim";
      nvchad.enable = lib.mkEnableOption "neovim.nvchad";
    };
    helix.enable = lib.mkEnableOption "helix";
  };
  config = lib.mkMerge [
    (
      lib.mkIf
      (
        config.${namespace}.terminal.editors.neovim.lazyvim.enable
        || config.${namespace}.terminal.editors.neovim.nvchad.enable
      )
      {
        home.sessionVariables.EDITOR = "nvim";
        home.shellAliases.vi = "nvim";
      }
    )
    (
      lib.mkIf
      (
        !(
          config.${namespace}.terminal.editors.neovim.lazyvim.enable
          || config.${namespace}.terminal.editors.neovim.nvchad.enable
        )
        && config.${namespace}.terminal.editors.helix.enable
      )
      {
        home.sessionVariables.EDITOR = "hx";
      }
    )
    {
      programs = lib.mkMerge [
        (lib.mkIf config.${namespace}.terminal.editors.neovim.lazyvim.enable {
          lazyvim = {
            enable = true;
            extras = {
              coding.yanky.enable = true;
              util.mini-hipatterns.enable = true;
              editor = {
                dial.enable = true;
                inc-rename.enable = true;
              };
              lang = {
                nix.enable = true;
                markdown.enable = true;
              };
              ai = {
                copilot.enable = true;
                copilot-chat.enable = true;
              };
            };
            pluginsFile."theme.lua".text = ''
              return {"LazyVim/LazyVim", opts = {colorscheme = "catppuccin"}}
            '';
          };
        })
        (lib.mkIf config.${namespace}.terminal.editors.neovim.nvchad.enable {
          nvchad = {
            enable = true;
            backup = false;
            chadrcConfig = ''
              local M = {
                  base46 = {theme = "catppuccin"},
                  nvdash = {load_on_startup = true}
              }
              return M
            '';
          };
        })
        (lib.mkIf config.${namespace}.terminal.editors.helix.enable {
          helix = {
            enable = true;
            settings = {
              editor = {
                line-number = "relative";
                cursorline = true;
                color-modes = true;
                lsp.display-messages = true;
                cursor-shape = {
                  insert = "bar";
                  normal = "block";
                  select = "underline";
                };
                indent-guides = {
                  render = true;
                };
              };
            };
          };
        })
      ];
    }
  ];
}
