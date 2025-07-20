{
  config,
  lib,
  flake,
  ...
}: {
  options.${flake.config.me.namespace}.graphical.apps.kodi.enable = lib.mkEnableOption "kodi";
  config = lib.mkIf config.${flake.config.me.namespace}.graphical.apps.kodi.enable {
    programs.kodi = {
      enable = true;
    };
  };
}
