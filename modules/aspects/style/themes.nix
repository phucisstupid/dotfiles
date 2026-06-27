{inputs, ...}: {
  flake-file.inputs.catppuccin = {
    url = "github:catppuccin/nix";
  };

  den.aspects.themes.catppuccin = {
    homeManager = {
      imports = [inputs.catppuccin.homeModules.catppuccin];
      catppuccin = {
        enable = true;
        autoEnable = true;
        flavor = "mocha";
        accent = "mauve";
        tmux.extraConfig = ''
          set -g status-position top
          set -g status-right-length 100
          set -g status-left-length 100
          set -g @catppuccin_window_status_style "rounded"
          set -g status-left ""
          set -g status-right "#{E:@catppuccin_status_session}"
          set -agF status-right "#{E:@catppuccin_status_battery}"
          set -agF status-right "#{E:@catppuccin_status_date_time}"
        '';
      };
    };
  };
}
