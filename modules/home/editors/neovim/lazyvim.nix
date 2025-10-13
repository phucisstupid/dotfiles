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
      pluginsFile = {
        "colorscheme.lua".source = "${inputs.dotfiles-stow}/.config/nvim/lua/plugins/colorscheme.lua";
        "editor.lua".source = "${inputs.dotfiles-stow}/.config/nvim/lua/plugins/editor.lua";
        "ui.lua".source = "${inputs.dotfiles-stow}/.config/nvim/lua/plugins/ui.lua";
      };
    }
    (lib.mkIf config.${namespace}.terminals.multiplexers.tmux.enable {
      plugins = [ pkgs.vimPlugins.vim-tmux-navigator ];
      pluginsFile."vim-tmux-navigator.lua".source =
        "${inputs.dotfiles-stow}/.config/nvim/lua/plugins/vim-tmux-navigator.lua";
    })
  ];
}
