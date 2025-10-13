{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.tools.pay-respects.enable = lib.mkEnableOption "pay-respects";
  config = lib.mkIf config.${namespace}.tools.pay-respects.enable {
    programs.pay-respects.enable = true;
  };
}
