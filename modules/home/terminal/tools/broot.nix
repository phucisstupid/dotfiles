{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.terminal.tools.broot.enable = lib.mkEnableOption "broot";
  config.programs.broot = {
    inherit (config.${namespace}.terminal.tools.broot) enable;
  };
}
