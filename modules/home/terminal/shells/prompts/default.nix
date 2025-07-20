{
  config,
  flake,
  ...
}: {
  programs = {
    starship = {
      inherit (config.${flake.config.me.namespace}.terminal.shells.prompts.starship) enable;
      enableTransience = true;
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
      };
    };
    oh-my-posh = {
      inherit (config.${flake.config.me.namespace}.terminal.shells.prompts.oh-my-posh) enable;
      useTheme = "pure";
    };
  };
}
