{
  config,
  lib,
  flake,
  ...
}:
let
  namespace = flake.config.me.namespace;
in
{
  options.${namespace}.graphical.apps.kodi.enable = lib.mkEnableOption "kodi";
  config = lib.mkIf config.${namespace}.graphical.apps.kodi.enable {
    programs.kodi = {
      enable = true;
    };
  };
}
