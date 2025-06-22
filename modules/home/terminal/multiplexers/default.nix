{
  config,
  pkgs,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.terminal.multiplexers = {
    tmux.enable = lib.mkEnableOption "tmux";
    zellij.enable = lib.mkEnableOption "zellij";
  };
  config = lib.mkMerge [
    (lib.mkIf config.${namespace}.terminal.multiplexers.tmux.enable {
      catppuccin.tmux.extraConfig = ''
                        set -g @catppuccin_window_status_style "rounded"
        set -g @catppuccin_window_text " #W "
                set -g @catppuccin_window_current_text " #W"
                set -g @catppuccin_window_flags "icon"
                        set -g status-left "#{E:@catppuccin_status_session}"
                        set -g status-right "#{E:@catppuccin_status_directory}"
                        set -agF status-right "#{E:@catppuccin_status_cpu}"
                        set -agF status-right "#{E:@catppuccin_status_weather}"
      '';
      programs.tmux = {
        enable = true;
        shortcut = "a";
        keyMode = "vi";
        baseIndex = 1;
        escapeTime = 0;
        disableConfirmationPrompt = true;
        tmuxinator.enable = true;
        plugins = with pkgs.tmuxPlugins; [
          yank
          cpu
          weather
          vim-tmux-navigator
        ];
        extraConfig = ''
          set -g status-position top
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
