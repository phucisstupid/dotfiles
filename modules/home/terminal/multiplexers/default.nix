{
  config,
  pkgs,
  lib,
  flake,
  ...
}:
let
  inherit (flake.config.me) namespace;
in
{
  options.${namespace}.terminal.multiplexers = {
    tmux.enable = lib.mkEnableOption "tmux";
    tmux.sesh.enable = lib.mkEnableOption "tmux.sesh";
    zellij.enable = lib.mkEnableOption "zellij";
  };
  config = lib.mkMerge [
    (lib.mkIf config.${namespace}.terminal.multiplexers.tmux.enable {
      catppuccin.tmux.extraConfig = ''
        set -g @catppuccin_window_status_style "rounded"
        set -g @catppuccin_window_flags "icon"
        set -g @catppuccin_window_current_text " #{b:pane_current_path}"
        set -g @catppuccin_window_text " #{b:pane_current_path}"
        set -g status-left "#{E:@catppuccin_status_session}"
        set -g status-right "#{E:@catppuccin_status_application}"
        set -agF status-right "#{E:@catppuccin_status_cpu}"
        set -agF status-right "#{E:@catppuccin_status_weather}"
        set -ag status-right "#{E:@catppuccin_status_uptime}"
      '';
      programs.tmux = {
        enable = true;
        # sensibleOnTop = true; # TODO: fix https://github.com/nix-community/home-manager/issues/6266
        terminal = "screen-256color";
        escapeTime = 0;
        shortcut = "a";
        keyMode = "vi";
        baseIndex = 1;
        disableConfirmationPrompt = true;
        plugins = with pkgs.tmuxPlugins; [
          cpu
          weather
          vim-tmux-navigator
          tmux-thumbs
          fzf-tmux-url
          tmux-floax
        ];
        extraConfig = ''
          set -g status-position top
          set -g status-right-length 100
          set -g status-left-length 100
          bind-key -T copy-mode-vi 'v' send-keys -X begin-selection
        '';
      };
    })
    (lib.mkIf config.${namespace}.terminal.multiplexers.tmux.sesh.enable {
      programs.sesh = {
        enable = true;
        settings = {
          session = [
            {
              name = "Downloads 📥";
              path = "~/Downloads";
              startup_command = "ls";
            }
          ];
        };
      };
    })
    (lib.mkIf config.${namespace}.terminal.multiplexers.zellij.enable {
      programs.zellij = {
        enable = true;
        settings.show_startup_tips = false;
      };
    })
  ];
}
