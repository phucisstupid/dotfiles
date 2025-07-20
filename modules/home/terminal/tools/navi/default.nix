{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.terminal.tools.navi.enable = lib.mkEnableOption "navi";
  config = lib.mkIf config.${namespace}.terminal.tools.navi.enable {
    programs.navi = {
      enable = true;
      settings = {
        client.tealdeer = true;
      };
    };
  };
}
