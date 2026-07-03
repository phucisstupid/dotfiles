_: {
  den.aspects.terminal.multiplexer = {
    tmux = {
      homeManager = {pkgs,...}: {
        programs.tmux = {
          enable = true;
          sensibleOnTop = true;
          terminal = "tmux-256color";
          shortcut = "a";
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
      };

      sesh = {
        homeManager = {
          programs.sesh = {
            enable = true;
            settings.session = [
              {
                name = "Downloads 📥";
                path = "~/Downloads";
                startup_command = "ls";
              }
            ];
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
