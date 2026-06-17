{
  config,
  pkgs,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.terminals.multiplexers = {
    tmux.enable = lib.mkEnableOption "Enable tmux";
    tmux.sesh.enable = lib.mkEnableOption "Enable tmux.sesh";
    zellij.enable = lib.mkEnableOption "Enable zellij";
  };
  config.programs = {
    tmux = {
      inherit (config.${namespace}.terminals.multiplexers.tmux) enable;
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
    sesh = {
      inherit (config.${namespace}.terminals.multiplexers.tmux.sesh) enable;
      settings.session = [
        {
          name = "Downloads 📥";
          path = "~/Downloads";
          startup_command = "ls";
        }
      ];
    };
    zellij = {
      inherit (config.${namespace}.terminals.multiplexers.zellij) enable;
      settings.show_startup_tips = false;
    };
  };
}
