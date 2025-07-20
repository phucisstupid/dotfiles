{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.terminal.tools.fzf.enable = lib.mkEnableOption "fzf";
  config = lib.mkIf config.${namespace}.terminal.tools.fzf.enable {
    programs.fzf = {
      enable = true;
      tmux.enableShellIntegration = true;
      defaultOptions = [
        "--height 40%"
        "--border"
      ];
    };
  };
}
