{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.tools.navi.enable = lib.mkEnableOption "navi";
  config = lib.mkIf config.${namespace}.tools.navi.enable {
    programs.navi = {
      enable = true;
      settings = {
        client.tealdeer = true;
      };
    };
  };
}
