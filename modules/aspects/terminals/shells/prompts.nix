_: {
  den.aspects.terminal.shell.prompt = {
    starship = {
      homeManager = {
        programs.starship = {
          enable = true;
          enableTransience = true;
          presets = ["nerd-font-symbols"];
          settings = {
            character = {
              success_symbol = "[[󰄛](green) ❯](peach)";
              error_symbol = "[[󰄛](red) ❯](peach)";
              vimcmd_symbol = "[󰄛 ❮](subtext1)";
            };
            directory = {
              truncation_length = 4;
              style = "bold lavender";
            };
            git_branch.style = "bold mauve";
            git_metrics.disabled = false;
            battery.display = [
              {threshold = 30;}
            ];
          };
        };
      };
    };

    oh-my-posh = {
      homeManager = {
        programs.oh-my-posh = {
          enable = true;
          useTheme = "pure";
        };
      };
    };
  };
}
