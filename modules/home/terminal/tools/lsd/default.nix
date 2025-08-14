{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.terminal.tools.lsd.enable = lib.mkEnableOption "lsd";
  config = lib.mkIf config.${namespace}.terminal.tools.lsd.enable {
    programs.lsd = {
      enable = true;
    };
  };
}
