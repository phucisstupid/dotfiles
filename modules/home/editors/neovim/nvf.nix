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
      options = {
        tabstop = 2;
        smartindent = true;
      };
      diagnostics.enable =
        true;
      undoFile.enable = true;
      viAlias = true;
      clipboard = {
        enable = true;
        registers = "unnamedplus";
      };
      lsp = {
        enable = true;
        inlayHints.enable = true;
        trouble.enable = true;
        formatOnSave = true;
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
          cmdline.keymap.preset = "cmdline";
        };
        friendly-snippets.enable = true;
      };
      assistant = {
        copilot.enable = true;
      };
      mini = {
        ai.enable = true;
        align.enable = true;
        animate.enable = true;
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
        jump.enable = true;
        jump2d.enable = true;
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
        surround.enable = true;
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
        clue = {
          enable = true;
          setupOpts = {
            clues = [
              (lib.generators.mkLuaInline "require('mini.clue').gen_clues.builtin_completion()")
              (lib.generators.mkLuaInline "require('mini.clue').gen_clues.g()")
              (lib.generators.mkLuaInline "require('mini.clue').gen_clues.marks()")
              (lib.generators.mkLuaInline "require('mini.clue').gen_clues.registers()")
              (lib.generators.mkLuaInline "require('mini.clue').gen_clues.windows({ submode_resize = true })")
              (lib.generators.mkLuaInline "require('mini.clue').gen_clues.z()")
              {
                mode = "n";
                key = "<Leader>b";
                desc = "+Buffer";
              }
              {
                mode = "n";
                key = "<Leader>e";
                desc = "+Explore/Edit";
              }
              {
                mode = "n";
                key = "<Leader>f";
                desc = "+Find";
              }
              {
                mode = "n";
                key = "<Leader>g";
                desc = "+Git";
              }
              {
                mode = "n";
                key = "<Leader>l";
                desc = "+Language";
              }
              {
                mode = "n";
                key = "<Leader>m";
                desc = "+Map";
              }
              {
                mode = "n";
                key = "<Leader>o";
                desc = "+Other";
              }
              {
                mode = "n";
                key = "<Leader>s";
                desc = "+Session";
              }
              {
                mode = "n";
                key = "<Leader>t";
                desc = "+Terminal";
              }
              {
                mode = "n";
                key = "<Leader>v";
                desc = "+Visits";
              }
              {
                mode = "x";
                key = "<Leader>g";
                desc = "+Git";
              }
              {
                mode = "x";
                key = "<Leader>l";
                desc = "+Language";
              }
            ];
            triggers = [
              {
                mode = "n";
                keys = "<Leader>";
              }
              {
                mode = "x";
                keys = "<Leader>";
              }
              {
                mode = "n";
                keys = "\\";
              }
              {
                mode = "n";
                keys = "[";
              }
              {
                mode = "n";
                keys = "]";
              }
              {
                mode = "x";
                keys = "[";
              }
              {
                mode = "x";
                keys = "]";
              }
              {
                mode = "i";
                keys = "<C-x>";
              }
              {
                mode = "n";
                keys = "g";
              }
              {
                mode = "x";
                keys = "g";
              }
              {
                mode = "n";
                keys = "'";
              }
              {
                mode = "n";
                keys = "`";
              }
              {
                mode = "x";
                keys = "'";
              }
              {
                mode = "x";
                keys = "`";
              }
              {
                mode = "n";
                keys = "\"";
              }
              {
                mode = "x";
                keys = "\"";
              }
              {
                mode = "i";
                keys = "<C-r>";
              }
              {
                mode = "c";
                keys = "<C-r>";
              }
              {
                mode = "n";
                keys = "<C-w>";
              }
              {
                mode = "n";
                keys = "z";
              }
              {
                mode = "x";
                keys = "z";
              }
            ];
          };
        };
      };
    };
  };
}
