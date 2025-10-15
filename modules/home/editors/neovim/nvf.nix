{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.editors.neovim.nvf.enable = lib.mkEnableOption "nvf";
  config.programs.nvf = {
    inherit (config.${namespace}.editors.neovim.nvf) enable;
    defaultEditor = true;
    settings.vim = {
      withNodeJs = true;
      options = {
        switchbuf = "usetab";
        shada = "'100,<50,s10,:1000,/100,@100,h";

        # UI
        breakindent = true;
        breakindentopt = "list:-1";
        colorcolumn = "+1";
        cursorline = true;
        linebreak = true;
        list = true;
        pumheight = 10;
        ruler = false;
        shortmess = "CFOSWaco";
        signcolumn = "yes";
        splitbelow = true;
        splitkeep = "screen";
        splitright = true;
        wrap = false;
        fillchars = "eob: ,fold:╌";
        listchars = "extends:…,nbsp:␣,precedes:…,tab:> ";

        # Folds
        foldlevel = 10;
        foldmethod = "indent";
        foldnestmax = 10;
        foldtext = "";

        # Editing
        autoindent = true;
        expandtab = true;
        formatoptions = "rqnl1j";
        ignorecase = true;
        incsearch = true;
        infercase = true;
        shiftwidth = 2;
        smartcase = true;
        smartindent = true;
        spelloptions = "camel";
        tabstop = 2;
        virtualedit = "block";
        iskeyword = "@,48-57,_,192-255,-";
        complete = ".,w,b,kspell";
        completeopt = "menuone,noselect,fuzzy,nosort";
      };
      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
      };
      undoFile.enable = true;
      viAlias = true;
      clipboard = {
        enable = true;
        registers = "unnamedplus";
      };
      lsp = {
        enable = true;
        formatOnSave = true;
        inlayHints.enable = true;
        trouble.enable = true;
      };
      languages = {
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;
        nix.enable = true;
        markdown.enable = true;
        # rust.enable = true;
      };
      autocomplete.blink-cmp = {
        enable = true;
        friendly-snippets.enable = true;
        setupOpts = {
          keymap.preset = "enter";
          cmdline.completion = {
            list.selection.preselect = false;
            menu.auto_show = lib.generators.mkLuaInline ''
              function(ctx)
                return vim.fn.getcmdtype() == ':'
              end
            '';
          };
        };
      };
      assistant.copilot.enable = true;
      binds.whichKey = {
        enable = true;
        setupOpts.preset = "helix";
      };
      utility = {
        motion.flash-nvim.enable = true;
        oil-nvim = {
          enable = true;
          gitStatus.enable = true;
        };
      };
      statusline.lualine.enable = true;
      tabline.nvimBufferline = {
        enable = true;
        setupOpts.options.always_show_bufferline = false;
      };
      telescope.enable = true;
      ui.noice.enable = true;
      autopairs.nvim-autopairs.enable = true;
      session.nvim-session-manager.enable = true;
      mini = {
        ai.enable = true;
        align.enable = true;
        animate = {
          enable = true;
          setupOpts = {
            cursor.enable = false;
          };
        };
        bracketed.enable = true;
        bufremove.enable = true;
        comment.enable = true;
        cursorword.enable = true;
        diff.enable = true;
        extra.enable = true;
        files.enable = true;
        git.enable = true;
        hipatterns.enable = true;
        icons.enable = true;
        indentscope.enable = true;
        map.enable = true;
        misc.enable = true;
        move.enable = true;
        operators.enable = true;
        splitjoin.enable = true;
        trailspace.enable = true;
        visits.enable = true;
        basics = {
          enable = true;
          setupOpts.mappings.windows = true;
        };
      };
    };
  };
}
