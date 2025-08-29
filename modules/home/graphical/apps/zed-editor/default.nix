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
  options.${namespace}.graphical.apps.zed-editor.enable = lib.mkEnableOption "zed-editor";
  config = lib.mkIf config.${namespace}.graphical.apps.zed-editor.enable {
    programs.zed-editor = {
      enable = true;
      userSettings = {
        vim_mode = true;
        vim.enable_vim_sneak = true;

        relative_line_numbers = true;
        buffer_font_family = "Maple Mono";
        buffer_font_size = 18;
        ui_font_size = 17;

        terminal = {
          font_family = "Maple Mono";
          env.EDITOR = "zed --wait";
        };

        telemetry = {
          metrics = false;
          diagnostics = false;
        };

        file_finder.modal_width = "medium";
        tab_bar.show = true;
        scrollbar.show = "never";
        tabs.show_diagnostics = "errors";

        indent_guides = {
          enabled = true;
          coloring = "indent_aware";
        };

        centered_layout = {
          left_padding = 0.15;
          right_padding = 0.15;
        };

        assistant = {
          default_model = {
            provider = "copilot_chat";
            model = "claude-3-7-sonnet";
          };
          version = "2";
        };

        language_models.ollama.api_url = "http://localhost:11434";
        inlay_hints.enabled = true;

        lsp.tailwindcss-language-server.settings.classAttributes = [
          "class"
          "className"
          "ngClass"
          "styles"
        ];

        languages = {
          TypeScript.inlay_hints = {
            enabled = true;
            show_parameter_hints = false;
            show_other_hints = true;
            show_type_hints = true;
          };

          Python = {
            format_on_save.language_server.name = "ruff";
            formatter.language_server.name = "ruff";
            language_servers = [
              "pyright"
              "ruff"
            ];
          };
        };

        git_panel.dock = "right";
        project_panel = {
          button = true;
          dock = "right";
          git_status = true;
        };
        outline_panel.dock = "right";
        collaboration_panel.dock = "left";
        notification_panel.dock = "left";
        chat_panel.dock = "left";

        file_types.Dockerfile = [
          "Dockerfile"
          "Dockerfile.*"
        ];
        file_types.JSON = [
          "json"
          "jsonc"
          "*.code-snippets"
        ];

        features.edit_prediction_provider = "zed";
      };
      extensions = [
        "git-firefly"
      ];
    };
  };
}
