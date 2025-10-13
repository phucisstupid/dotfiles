{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.tools.tealdeer.enable = lib.mkEnableOption "tealdeer";
  config = lib.mkIf config.${namespace}.tools.tealdeer.enable {
    programs.tealdeer = {
      enable = true;
      settings.updates.auto_update = true;
    };
  };
}
