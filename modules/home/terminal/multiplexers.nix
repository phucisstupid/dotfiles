{
  config,
  pkgs,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.terminal.multiplexers = {
    tmux.enable = lib.mkEnableOption "Enable tmux";
    tmux.sesh.enable = lib.mkEnableOption "Enable tmux.sesh";
    zellij.enable = lib.mkEnableOption "Enable zellij";
  };
  config.programs = {
    tmux = {
      inherit (config.${namespace}.terminal.multiplexers.tmux) enable;
      sensibleOnTop = true;
      shortcut = "a";
      keyMode = "vi";
      baseIndex = 1;
      disableConfirmationPrompt = true;
      plugins = with pkgs.tmuxPlugins; [
        yank
        cpu
        weather
        vim-tmux-navigator
        tmux-floax
        {
          plugin = fingers;
          extraConfig = ''
            set -g @fingers-key space
          '';
        }
      ];
      extraConfig = ''
        set -ga terminal-overrides ",*:Tc"
        set -g status-position top
        set -g status-right-length 100
        set -g status-left-length 100
      '';
    };
    sesh = {
      inherit (config.${namespace}.terminal.multiplexers.tmux.sesh) enable;
      settings.session = [
        {
          name = "Downloads 📥";
          path = "~/Downloads";
          startup_command = "ls";
        }
      ];
    };
    zellij = {
      inherit (config.${namespace}.terminal.multiplexers.zellij) enable;
      settings.show_startup_tips = false;
    };
  };
}
