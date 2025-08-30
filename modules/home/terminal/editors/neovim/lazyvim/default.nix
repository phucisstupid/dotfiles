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
  options.${namespace}.terminal.editors.neovim.lazyvim.enable = lib.mkEnableOption "neovim.lazyvim";
  config = lib.mkIf config.${namespace}.terminal.editors.neovim.lazyvim.enable {
    programs = {
      neovim = {
        defaultEditor = true;
        viAlias = true;
      };
      lazyvim = lib.mkMerge [
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
            };
            ai.copilot.enable = true;
          };
          pluginsFile = {
            "colorscheme.lua".source = "${inputs.dotfiles-stow}/.config/nvim/lua/plugins/colorscheme.lua";
            "editor.lua".source = "${inputs.dotfiles-stow}/.config/nvim/lua/plugins/editor.lua";
            "ui.lua".source = "${inputs.dotfiles-stow}/.config/nvim/lua/plugins/ui.lua";
          };
        }
        (lib.mkIf config.${namespace}.terminal.multiplexers.tmux.enable {
          plugins = [ pkgs.vimPlugins.vim-tmux-navigator ];
          pluginsFile."vim-tmux-navigator.lua".source =
            "${inputs.dotfiles-stow}/.config/nvim/lua/plugins/vim-tmux-navigator.lua";
        })
      ];
    };
  };
}
