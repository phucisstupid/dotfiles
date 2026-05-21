# Optional editor aspects.
{den, ...}: let
  perUser = homeManager: den.lib.perUser {inherit homeManager;};
in {
  den.aspects.helix.includes = [
    (perUser {
      programs.helix = {
        enable = true;
        defaultEditor = true;
        settings.editor = {
          line-number = "relative";
          cursor-shape.insert = "bar";
        };
      };
    })
  ];

  den.aspects.zed-editor.includes = [
    (perUser {
      programs.zed-editor = {
        enable = true;
        userSettings = {
          session.trust_all_worktrees = true;
          git.inline_blame.enabled = true;
          gutter.line_numbers = true;
          cursor_shape = "bar";
          cursor_blink = false;
          use_system_window_tabs = true;
          show_whitespaces = "all";
          show_edit_predictions = true;
          hard_tabs = true;
          vim_mode = true;
          which_key.enabled = true;
          relative_line_numbers = "enabled";
          tab_bar.show = true;
          scrollbar.show = "never";
          tabs.show_diagnostics = "errors";
          indent_guides = {
            enabled = true;
            coloring = "indent_aware";
          };
          ui_font_size = 17;
          buffer_font_size = 18.5;
          buffer_font_family = "Maple Mono NF";
          terminal = {
            font_size = 17.0;
            font_family = "Maple Mono NF";
            env.EDITOR = "zed --wait";
          };
          telemetry = {
            diagnostics = false;
            metrics = false;
          };
          project_panel = {
            auto_fold_dirs = false;
            button = true;
            dock = "right";
            git_status = true;
          };
          outline_panel.dock = "right";
          collaboration_panel.dock = "left";
          notification_panel.dock = "left";
        };
      };
    })
  ];

  den.aspects.nvf.includes = [
    (perUser {
      programs.nvf = {
        enable = true;
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
          searchCase = "smart";
          options = {
            wrap = false;
            colorcolumn = "+1";
            list = true;
            shiftwidth = 2;
            tabstop = 2;
            expandtab = true;
          };
          lsp = {
            enable = true;
            formatOnSave = true;
            inlayHints.enable = true;
            trouble.enable = true;
          };
          diagnostics.enable = true;
          languages = {
            enableFormat = true;
            enableTreesitter = true;
            enableExtraDiagnostics = true;
            nix.enable = true;
            markdown.enable = true;
            lua.enable = true;
          };
          autocomplete.blink-cmp = {
            enable = true;
            friendly-snippets.enable = true;
          };
          assistant.copilot.enable = true;
          binds.whichKey.enable = true;
          utility.motion.flash-nvim.enable = true;
          utility.snacks-nvim.enable = true;
          utility.oil-nvim = {
            enable = true;
            gitStatus.enable = true;
          };
          statusline.lualine.enable = true;
          tabline.nvimBufferline.enable = true;
          telescope.enable = true;
          ui.noice.enable = true;
          autopairs.nvim-autopairs.enable = true;
          session.nvim-session-manager.enable = true;
        };
      };
    })
  ];

  den.aspects.nvchad.includes = [
    (perUser {
      programs.nvchad = {
        enable = true;
        chadrcConfig = ''
          local M = {}
          M = {
            base46 = { theme = "catppuccin" },
            nvdash = { load_on_startup = true },
          }
          return M
        '';
      };
    })
  ];
}
