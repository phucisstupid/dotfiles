{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.tools.nh.enable = lib.mkEnableOption "nh";
  config = lib.mkIf config.${namespace}.tools.nh.enable {
    programs.nh = {
      enable = true;
      flake = ../../../..;
      clean.enable = true;
    };
  };
}
