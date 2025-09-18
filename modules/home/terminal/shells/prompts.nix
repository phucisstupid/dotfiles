{
  config,
  flake,
  lib,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.terminal.shells.prompts = {
    starship.enable = lib.mkEnableOption "starship";
    oh-my-posh.enable = lib.mkEnableOption "oh-my-posh";
  };
  config.programs = with config.${namespace}.terminal.shells.prompts; {
    starship = {
      inherit (starship) enable;
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
      inherit (oh-my-posh) enable;
      useTheme = "pure";
    };
  };
}
