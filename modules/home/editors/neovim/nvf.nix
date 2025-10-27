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
      viAlias = true;
      withNodeJs = true;
      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
      };
      clipboard = {
        enable = true;
        registers = "unnamedplus";
      };
      autocmds = [
        {
          event = ["InsertEnter" "CmdlineEnter"];
          desc = "Unmap <Esc> during insert/cmdline modes";
          command = "silent! nunmap <Esc>";
        }
        {
          event = ["InsertLeave" "CmdlineLeave"];
          desc = "Remap <Esc> to clear search highlight in normal mode";
          command = "nnoremap <silent> <Esc> :nohlsearch<CR>";
        }
      ];
      searchCase = "smart";
      options = {
        switchbuf = "usetab";
        shada = "'100,<50,s10,:1000,/100,@100,h";

        # UI
        wrap = false;
        breakindentopt = "list:-1";
        colorcolumn = "+1";
        list = true;
        pumheight = 10;
        fillchars = "eob: ,fold:╌";
        listchars = "extends:…,nbsp:␣,precedes:…,tab:> ";

        # Folds
        foldlevel = 10;
        foldmethod = "indent";
        foldnestmax = 10;
        foldtext = "";

        # Editing
        confirm = true;
        autoindent = true;
        expandtab = true;
        formatoptions = "rqnl1j";
        shiftwidth = 2;
        spelloptions = "camel";
        tabstop = 2;
        iskeyword = "@,48-57,_,192-255,-";
        completeopt = "menu,menuone,noselect";
      };
      lsp = {
        enable = true;
        formatOnSave = true;
        inlayHints.enable = true;
        trouble.enable = true;
      };
      diagnostics = {
        enable = true;
        config = {
          virtual_text.enable = true;
          severity_sort = true;
          signs.text = lib.generators.mkLuaInline ''
            {
              [vim.diagnostic.severity.ERROR] = " ",
              [vim.diagnostic.severity.WARN] = " ",
              [vim.diagnostic.severity.INFO] = " ",
              [vim.diagnostic.severity.HINT] = " ",
            }
          '';
        };
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
        snacks-nvim = {
          enable = true;
          setupOpts = {
            input.enable = true;
            notifier.enable = true;
            scroll.enable = true;
          };
        };
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
