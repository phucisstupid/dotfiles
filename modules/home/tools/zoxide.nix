{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.tools.zoxide.enable = lib.mkEnableOption "zoxide";
  config.programs.zoxide = {
    inherit (config.${namespace}.tools.zoxide) enable;
    options = ["--cmd=cd"];
  };
}
