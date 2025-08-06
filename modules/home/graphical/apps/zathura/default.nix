{
  config,
  lib,
  flake,
  ...
}:
{
  options.${flake.config.me.namespace}.graphical.apps.zathura.enable = lib.mkEnableOption "zathura";
  config = lib.mkIf config.${flake.config.me.namespace}.graphical.apps.zathura.enable {
    programs.zathura = {
      enable = true;
    };
  };
}
