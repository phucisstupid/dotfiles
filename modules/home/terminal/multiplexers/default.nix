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
    zellij.enable = lib.mkEnableOption "zellij";
  };
  config = lib.mkMerge [
    (lib.mkIf config.${namespace}.terminal.multiplexers.tmux.enable {
      catppuccin.tmux.extraConfig = ''
        set -g @catppuccin_pane_status_enabled "yes"
        set -g @catppuccin_pane_border_status "yes"
        set -g @catppuccin_window_status_style "rounded"
        set -g @catppuccin_window_current_text " #W"
        set -g @catppuccin_window_text " #W "
        set -g @catppuccin_window_flags "icon"
        set -g status-left "#{E:@catppuccin_status_session}"
        set -g status-right "#{E:@catppuccin_status_directory}"
        set -agF status-right "#{E:@catppuccin_status_cpu}"
        set -agF status-right "#{E:@catppuccin_status_weather}"
        set -g @catppuccin_status_connect_separator "no"
        set -g @catppuccin_status_right_separator " "
      '';
      programs.tmux = {
        enable = true;
        terminal = "screen-256color";
        shortcut = "a";
        keyMode = "vi";
        baseIndex = 1;
        escapeTime = 0;
        clock24 = true;
        disableConfirmationPrompt = true;
        plugins = with pkgs.tmuxPlugins; [
          cpu
          weather
          vim-tmux-navigator
          tmux-sessionx
          {
            plugin = tmux-floax;
            extraConfig = ''
              set -g @floax-bind H
            '';
          }
        ];
        extraConfig = ''
          set -ga terminal-overrides ",*:Tc"
          set -g status-position top
          set -g status-right-length 100
          set -g status-left-length 100
          bind-key -T copy-mode-vi 'C-h' select-pane -L
          bind-key -T copy-mode-vi 'C-j' select-pane -D
          bind-key -T copy-mode-vi 'C-k' select-pane -U
          bind-key -T copy-mode-vi 'C-l' select-pane -R
          bind-key -T copy-mode-vi 'v' send-keys -X begin-selection
        '';
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
