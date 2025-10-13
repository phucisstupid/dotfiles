{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.apps.kodi.enable = lib.mkEnableOption "kodi";
  config = lib.mkIf config.${namespace}.apps.kodi.enable {
    programs.kodi = {
      enable = true;
    };
  };
}
