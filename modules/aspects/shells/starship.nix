{ ...}: let
  starship = {
    homeManager.programs.starship = {
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
in {
  den.aspects.starship.includes = [starship];
}
