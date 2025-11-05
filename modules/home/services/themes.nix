{
  config,
  pkgs,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.services.themes = {
    catppuccin.enable = lib.mkEnableOption "catppuccin";
    stylix.enable = lib.mkEnableOption "stylix.catppuccin";
  };
  config = with config.${namespace}.services.themes; {
    catppuccin = {
      inherit (catppuccin) enable;
      flavor = "mocha";
      accent = "mauve";
      wezterm.apply = true; # TODO: remove when catppuccin/nix fix wezterm
      tmux.extraConfig = ''
        set -g @catppuccin_window_flags "icon"
        set -g @catppuccin_window_status_style "rounded"
        set -g @catppuccin_window_current_text " #{b:pane_current_path}"
        set -g @catppuccin_window_text " #{b:pane_current_path}"
        set -g status-left "#{E:@catppuccin_status_session}"
        set -g status-right "#{E:@catppuccin_status_application}"
        set -agF status-right "#{E:@catppuccin_status_cpu}"
        set -agF status-right "#{E:@catppuccin_status_weather}"
        set -ag status-right "#{E:@catppuccin_status_uptime}"
      '';
    };
    stylix = {
      inherit (stylix) enable;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      fonts = {
        sizes.applications = 17;
        monospace = {
          package = pkgs.maple-mono.NF;
          name = "Maple Mono NF";
        };
        serif = config.stylix.fonts.monospace;
        sansSerif = config.stylix.fonts.monospace;
        emoji = config.stylix.fonts.monospace;
      };
    };
  };
}
