_: {
  den.aspects.multiplexer = {
    tmux = {
      homeManager = { pkgs, ... }: {
        programs = {
          tmux = {
            enable = true;
            sensibleOnTop = true;
            terminal = "tmux-256color";
            keyMode = "vi";
            customPaneNavigationAndResize = true;
            baseIndex = 1;
            plugins = with pkgs.tmuxPlugins; [
              extrakto
              cpu
              weather
              battery
              vim-tmux-navigator
              tmux-window-name
            ];
            extraConfig = ''
              set -ga terminal-overrides ",*:Tc"
            '';
          };
          sesh = {
            enable = true;
          };
        };
      };
    };

    zellij = {
      homeManager = {
        programs.zellij = {
          enable = true;
          settings.show_startup_tips = false;
        };
      };
    };
  };
}
