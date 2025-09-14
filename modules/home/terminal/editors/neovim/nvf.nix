{
  config,
  lib,
  flake,
  ...
}:
let
  inherit (flake.config.me) namespace;
in
{
  options.${namespace}.terminal.editors.neovim.nvf.enable = lib.mkEnableOption "nvf";
  config.programs.nvf = {
    inherit (config.${namespace}.terminal.editors.neovim.nvf) enable;
    defaultEditor = true;
    settings.vim = {
      viAlias = true;
      clipboard.enable = true;
      lsp = {
        formatOnSave = true;
        enable = true;
        trouble.enable = true;
      };
      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
      };
      utility = {
        snacks-nvim.enable = true;
        yanky-nvim.enable = true;
        smart-splits.enable = true;
        oil-nvim.enable = true;
        motion = {
          flash-nvim.enable = true;
          precognition.enable = true;
        };
      };
      languages = {
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;
        nix.enable = true;
        lua.enable = true;
        markdown.enable = true;
        rust.enable = true;
      };
      git.enable = true;
      binds.whichKey = {
        enable = true;
        setupOpts.preset = "helix";
      };
      ui = {
        borders.enable = true;
        noice.enable = true;
      };
      visuals.fidget-nvim.enable = true;
      autocomplete.blink-cmp = {
        enable = true;
        friendly-snippets.enable = true;
      };
      assistant = {
        copilot = {
          enable = true;
          cmp.enable = true;
        };
        codecompanion-nvim.enable = true;
      };
      mini = {
        ai.enable = true;
        hipatterns.enable = true;
        icons.enable = true;
        pairs.enable = true;
        surround.enable = true;
      };
      notes.todo-comments.enable = true;
      comments.comment-nvim.enable = true;
      tabline.nvimBufferline.enable = true;
      statusline.lualine.enable = true;
    };
  };
}
