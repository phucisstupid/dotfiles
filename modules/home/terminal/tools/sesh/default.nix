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
  options.${namespace}.terminal.tools.sesh.enable = lib.mkEnableOption "sesh";
  config = lib.mkIf config.${namespace}.terminal.tools.sesh.enable {
    programs.sesh = {
      enable = true;
    };
  };
}
