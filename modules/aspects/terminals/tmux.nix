_: let
  tmux = {
    homeManager = {pkgs, ...}: {
      programs = {
        tmux = {
          enable = true;
          sensibleOnTop = true;
          terminal = "tmux-256color";
          shortcut = "a";
          keyMode = "vi";
          customPaneNavigationAndResize = true;
          baseIndex = 1;
          plugins = with pkgs.tmuxPlugins; [
            yank
            cpu
            weather
            battery
            vim-tmux-navigator
            {
              plugin = fingers;
              extraConfig = ''
                set -g @fingers-key space
              '';
            }
          ];
          extraConfig = ''
            set -ga terminal-overrides ",*:Tc"
          '';
        };
        sesh = {
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
in {
  den.aspects.tmux.includes = [tmux];
}
