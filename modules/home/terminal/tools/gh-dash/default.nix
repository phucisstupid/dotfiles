{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.terminal.tools.gh-dash.enable = lib.mkEnableOption "gh-dash";
  config = lib.mkIf config.${namespace}.terminal.tools.gh-dash.enable {
    programs.gh-dash.enable = true;
  };
}
