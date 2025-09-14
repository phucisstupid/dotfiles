{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.terminal.tools.zoxide.enable = lib.mkEnableOption "zoxide";
  config.programs.zoxide = {
    inherit (config.${namespace}.terminal.tools.zoxide) enable;
    options = ["--cmd=cd"];
  };
}
