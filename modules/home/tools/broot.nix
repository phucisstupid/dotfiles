{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.tools.broot.enable = lib.mkEnableOption "broot";
  config.programs.broot = {
    inherit (config.${namespace}.tools.broot) enable;
  };
}
