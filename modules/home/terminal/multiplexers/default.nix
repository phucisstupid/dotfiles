{
  config,
  lib,
  flake,
  ...
}:
let
  inherit (flake.config.me) namespace;
in
{
  options.${namespace}.terminal.multiplexers = {
    tmux.enable = lib.mkEnableOption "tmux";
    zellij.enable = lib.mkEnableOption "zellij";
  };
  config.programs = lib.mkMerge [
    (lib.mkIf config.${namespace}.terminal.multiplexers.tmux.enable {
      tmux = {
        enable = true;
        mouse = true;
        prefix = "C-a";
        tmuxinator.enable = true;
        keyMode = "vi";
      };
    })
    (lib.mkIf config.${namespace}.terminal.multiplexers.zellij.enable {
      zellij = {
        enable = true;
        settings.show_startup_tips = false;
      };
    })
  ];
}
