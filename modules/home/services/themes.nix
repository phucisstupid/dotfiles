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
        set -g status-position top
        set -g status-right-length 100
        set -g status-left-length 100
        set -g @catppuccin_window_current_text " #W"
        set -g @catppuccin_window_text " #W"
        set -g @catppuccin_status_background "none"
        set -g status-left ""
        set -g status-right "#{E:@catppuccin_status_session}"
        set -agF status-right "#{E:@catppuccin_status_battery}"
        set -agF status-right "#{E:@catppuccin_status_date_time}"
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
