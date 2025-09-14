{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.terminal.tools.tealdeer.enable = lib.mkEnableOption "tealdeer";
  config = lib.mkIf config.${namespace}.terminal.tools.tealdeer.enable {
    programs.tealdeer = {
      enable = true;
      settings.updates.auto_update = true;
    };
  };
}
