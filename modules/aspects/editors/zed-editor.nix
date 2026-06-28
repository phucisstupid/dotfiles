_: {
  den.aspects.editor.zed-editor = {
    homeManager = {
      programs.zed-editor = {
        enable = true;
        userSettings = {
          session = {
            trust_all_worktrees = true;
          };

          git = {
            inline_blame = {
              enabled = true;
            };
          };

          gutter = {
            line_numbers = true;
          };

          cursor_shape = "bar";
          cursor_blink = false;
          use_system_window_tabs = true;
          show_whitespaces = "all";
          show_edit_predictions = true;
          hard_tabs = true;

          git_panel = {
            tree_view = true;
            dock = "right";
          };

          icon_theme = {
            mode = "dark";
            light = "Catppuccin Mocha";
            dark = "Catppuccin Mocha";
          };

          ui_font_size = 17;
          buffer_font_size = 18.5;

          file_finder = {
            modal_max_width = "medium";
          };

          buffer_font_family = "Maple Mono NF";

          vim_mode = true;

          which_key = {
            enabled = true;
          };

          relative_line_numbers = "enabled";

          tab_bar = {
            show = true;
          };

          scrollbar = {
            show = "never";
          };

          tabs = {
            show_diagnostics = "errors";
          };

          indent_guides = {
            enabled = true;
            coloring = "indent_aware";
          };

          centered_layout = {
            left_padding = 0.15;
            right_padding = 0.15;
          };

          inlay_hints = {
            enabled = true;
          };

          lsp = {
            "tailwindcss-language-server" = {
              settings = {
                classAttributes = [
                  "class"
                  "className"
                  "ngClass"
                  "styles"
                ];
              };
            };
          };

          languages = {
            TypeScript = {
              show_whitespaces = "all";
              show_edit_predictions = true;
              hard_tabs = true;
              inlay_hints = {
                enabled = true;
                show_parameter_hints = false;
                show_other_hints = true;
                show_type_hints = true;
              };
            };

            Python = {
              show_whitespaces = "all";
              show_edit_predictions = true;
              hard_tabs = true;
              format_on_save = "on";
              formatter = {
                language_server = {
                  name = "ruff";
                };
              };
              language_servers = [
                "ty"
                "ruff"
                "!basedpyright"
                "!pyrefly"
                "!pyright"
                "!pylsp"
              ];
            };
          };

          terminal = {
            font_size = 17.0;
            font_family = "Maple Mono NF";
            env = {
              EDITOR = "zed --wait";
            };
          };

          file_types = {
            Dockerfile = [
              "Dockerfile"
              "Dockerfile.*"
            ];
            JSON = [
              "json"
              "jsonc"
              "*.code-snippets"
            ];
          };

          file_scan_exclusions = [
            "**/.git"
            "**/.svn"
            "**/.hg"
            "**/CVS"
            "**/.DS_Store"
            "**/Thumbs.db"
            "**/.classpath"
            "**/.settings"
            "**/out"
            "**/dist"
            "**/.husky"
            "**/.turbo"
            "**/.vscode-test"
            "**/.vscode"
            "**/.next"
            "**/.storybook"
            "**/.tap"
            "**/.nyc_output"
            "**/report"
            "**/node_modules"
          ];

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

          outline_panel = {
            dock = "right";
          };
          collaboration_panel = {
            dock = "left";
          };
          notification_panel = {
            dock = "left";
          };
        };
      };
    };
  };
}
