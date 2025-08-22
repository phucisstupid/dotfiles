{
  config,
  pkgs,
  lib,
  flake,
  ...
}:
let
  inherit (flake.config.me) namespace;
  inherit (flake) inputs;
in
{
  options.${namespace}.terminal.editors = {
    neovim = {
      lazyvim.enable = lib.mkEnableOption "neovim.lazyvim";
      nvchad.enable = lib.mkEnableOption "neovim.nvchad";
    };
    helix.enable = lib.mkEnableOption "helix";
  };
  config = lib.mkMerge [
    (lib.mkIf
      (
        config.${namespace}.terminal.editors.neovim.lazyvim.enable
        || config.${namespace}.terminal.editors.neovim.nvchad.enable
      )
      {
        programs.neovim = {
          defaultEditor = true;
          viAlias = true;
        };
      }
    )
    (lib.mkIf
      (
        !(
          config.${namespace}.terminal.editors.neovim.lazyvim.enable
          || config.${namespace}.terminal.editors.neovim.nvchad.enable
        )
        && config.${namespace}.terminal.editors.helix.enable
      )
      {
        programs.helix.defaultEditor = true;
      }
    )
    (lib.mkIf config.${namespace}.terminal.editors.neovim.lazyvim.enable {
      programs.lazyvim = lib.mkMerge [
        {
          enable = true;
          extras = {
            coding = {
              mini-surround.enable = true;
              yanky.enable = true;
            };
            util.mini-hipatterns.enable = true;
            editor = {
              dial.enable = true;
              inc-rename.enable = true;
            };
            lang = {
              nix.enable = true;
              markdown.enable = true;
              # rust.enable = true;
            };
            ai.copilot.enable = true;
          };
          pluginsFile = {
            "colorscheme.lua".source = "${inputs.dotfiles-stow}/nvim/lua/plugins/colorscheme.lua";
            "editor.lua".source = "${inputs.dotfiles-stow}/nvim/lua/plugins/editor.lua";
            "ui.lua".source = "${inputs.dotfiles-stow}/nvim/lua/plugins/ui.lua";
          };
        }
        (lib.mkIf config.${namespace}.terminal.multiplexers.tmux.enable {
          plugins = [ pkgs.vimPlugins.vim-tmux-navigator ];
          pluginsFile."vim-tmux-navigator.lua".source =
            "${inputs.dotfiles-stow}/nvim/lua/plugins/vim-tmux-navigator.lua";
        })
      ];
    })
    (lib.mkIf config.${namespace}.terminal.editors.neovim.nvchad.enable {
      programs.nvchad = {
        enable = true;
        chadrcConfig = ''
          local M = {}
          M = {
            base46 = {
              theme = "catppuccin",
            },
            nvdash = {
              load_on_startup = true,
            },
          }
          return M
        '';
      };
    })
    (lib.mkIf config.${namespace}.terminal.editors.helix.enable {
      programs.helix = {
        enable = true;
        languages = {
          language = [
            {
              name = "nix";
            }
          ];
        };
        settings.editor = {
          line-number = "relative";
          cursor-shape.insert = "bar";
        };
      };
    })
  ];
}
