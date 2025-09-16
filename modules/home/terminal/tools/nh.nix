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
  options.${namespace}.terminal.tools.nh.enable = lib.mkEnableOption "nh";
  config = lib.mkIf config.${namespace}.terminal.tools.nh.enable {
    programs.nh = {
      enable = true;
      flake = ../../../..;
      clean.enable = true;
    };
  };
}
