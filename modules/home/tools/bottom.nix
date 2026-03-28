{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.tools.bottom.enable = lib.mkEnableOption "bottom";
  config = lib.mkIf config.${namespace}.tools.bottom.enable {
    programs.bottom = {
      enable = true;
    };
  };
}
