{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.services.themes = {
    catppuccin.enable = lib.mkEnableOption "catppuccin";
  };
  config = with config.${namespace}.services.themes; {
    catppuccin = {
      inherit (catppuccin) enable;
      flavor = "mocha";
      accent = "mauve";
      tmux.extraConfig = ''
        set -g status-position top
        set -g status-right-length 100
        set -g status-left-length 100
        set -g @catppuccin_window_status_style "rounded"
        set -g @catppuccin_window_current_text " #W"
        set -g @catppuccin_window_text " #W"
        set -g status-left ""
        set -g status-right "#{E:@catppuccin_status_session}"
        set -agF status-right "#{E:@catppuccin_status_battery}"
        set -agF status-right "#{E:@catppuccin_status_date_time}"
      '';
    };
  };
}
