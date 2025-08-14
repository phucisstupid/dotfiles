{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.terminal.tools.bottom.enable = lib.mkEnableOption "bottom";
  config = lib.mkIf config.${namespace}.terminal.tools.bottom.enable {
    programs.bottom = {
      enable = true;
    };
  };
}
