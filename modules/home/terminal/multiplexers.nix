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
    tmux.enable = lib.mkEnableOption "Enable tmux";
    tmux.sesh.enable = lib.mkEnableOption "Enable tmux.sesh";
    zellij.enable = lib.mkEnableOption "Enable zellij";
  };
  config = {
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
    programs = {
      tmux = {
        inherit (config.${namespace}.terminal.multiplexers.tmux) enable;
        # sensibleOnTop = true; # TODO: fix https://github.com/nix-community/home-manager/issues/6266
        terminal = "screen-256color";
        escapeTime = 0;
        shortcut = "a";
        keyMode = "vi";
        baseIndex = 1;
        disableConfirmationPrompt = true;
        plugins = with pkgs.tmuxPlugins; [
          yank
          cpu
          weather
          vim-tmux-navigator
          {
            plugin = fingers;
            extraConfig = ''
              set -g @fingers-key space
            '';
          }
          fzf-tmux-url
          tmux-floax
        ];
        extraConfig = ''
          set -ga terminal-overrides ",*:Tc"
          set -g status-position top
          set -g status-right-length 100
          set -g status-left-length 100
        '';
      };
      sesh = {
        inherit (config.${namespace}.terminal.multiplexers.tmux.sesh) enable;
        settings.session = [
          {
            name = "Downloads 📥";
            path = "~/Downloads";
            startup_command = "ls";
          }
        ];
      };
      zellij = {
        inherit (config.${namespace}.terminal.multiplexers.zellij) enable;
        settings.show_startup_tips = false;
      };
    };
  };
}
