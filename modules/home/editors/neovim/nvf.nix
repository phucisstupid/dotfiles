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
  options.${namespace}.editors.neovim.nvf.enable = lib.mkEnableOption "nvf";
  config.programs.nvf = {
    inherit (config.${namespace}.editors.neovim.nvf) enable;
    defaultEditor = true;
    settings.vim = {
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
        showmode = false;
        signcolumn = "yes";
        splitbelow = true;
        splitkeep = "screen";
        splitright = true;
        wrap = false;
        cursorlineopt = "both";
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
        formatlistpat = ''^\s*[0-9\-\+\*]\+[\.\)]*\s\+''; # must be quoted
        complete = ".,w,b,kspell";
        completeopt = "menuone,noselect,fuzzy,nosort";
      };
      diagnostics.enable = true;
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
        trouble = {
          enable = true;
          setupOpts = {
            modes.lsp.win.position = "right";
          };
        };
      };
      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
      };
      languages = {
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;
        nix.enable = true;
        lua.enable = true;
        markdown.enable = true;
        rust.enable = false;
      };
      autocomplete.blink-cmp = {
        enable = true;
        setupOpts = {
          keymap.preset = "enter";
          cmdline = {
            completion.menu.auto_show = true;
          };
          friendly-snippets.enable = true;
        };
      };
      assistant = {
        copilot.enable = true;
      };
      binds.whichKey = {
        enable = true;
        setupOpts.preset = "helix";
      };
      utility.motion.flash-nvim.enable = true;
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
        fuzzy.enable = true;
        git.enable = true;
        hipatterns.enable = true;
        icons.enable = true;
        indentscope.enable = true;
        map.enable = true;
        misc.enable = true;
        move.enable = true;
        notify.enable = true;
        operators.enable = true;
        pairs.enable = true;
        pick.enable = true;
        sessions.enable = true;
        snippets.enable = true;
        splitjoin.enable = true;
        starter.enable = true;
        statusline.enable = true;
        tabline.enable = true;
        test.enable = true;
        trailspace.enable = true;
        visits.enable = true;
        basics = {
          enable = true;
          setupOpts = {
            mappings.windows = true;
          };
        };
      };
    };
  };
}
