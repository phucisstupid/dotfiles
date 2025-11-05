{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.editors.zed-editor.enable = lib.mkEnableOption "zed-editor";
  config = lib.mkIf config.${namespace}.editors.zed-editor.enable {
    programs.zed-editor = {
      enable = true;
      userSettings = {
        redact_private_values = true;

        git_panel = {
          dock = "right";
        };

        features = {
          edit_prediction_provider = "zed";
        };

        ui_font_size = 17;
        buffer_font_size = 18;

        file_finder = {
          modal_max_width = "medium";
        };

        buffer_font_family = "Maple Mono NF";

        vim_mode = true;

        relative_line_numbers = true;

        tab_bar = {show = true;};

        scrollbar = {show = "never";};

        tabs = {show_diagnostics = "errors";};

        indent_guides = {
          enabled = true;
          coloring = "indent_aware";
        };

        centered_layout = {
          left_padding = 0.15;
          right_padding = 0.15;
        };

        agent = {
          default_model = {
            provider = "copilot_chat";
            model = "gpt-4o";
          };
        };

        language_models = {
          ollama = {
            api_url = "http://localhost:11434";
          };
        };

        inlay_hints = {enabled = true;};

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
            inlay_hints = {
              enabled = true;
              show_parameter_hints = false;
              show_other_hints = true;
              show_type_hints = true;
            };
          };

          Python = {
            format_on_save = "on";
            formatter = {
              language_server = {name = "ruff";};
            };
            language_servers = ["pyright" "ruff"];
          };
        };

        terminal = {
          font_family = "Maple Mono NF";
          env = {EDITOR = "zed --wait";};
        };

        file_types = {
          Dockerfile = ["Dockerfile" "Dockerfile.*"];
          JSON = ["json" "jsonc" "*.code-snippets"];
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
          button = true;
          dock = "right";
          git_status = true;
        };

        outline_panel = {dock = "right";};
        collaboration_panel = {dock = "left";};
        notification_panel = {dock = "left";};
      };
    };
  };
}
