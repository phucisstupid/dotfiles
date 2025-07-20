{
  config,
  lib,
  flake,
  ...
}: {
  options.${flake.config.me.namespace}.graphical.screenlockers.hyprlock.enable = lib.mkEnableOption "hyprlock";
  config = lib.mkIf config.${flake.config.me.namespace}.graphical.screenlockers.hyprlock.enable {
    programs.hyprlock = {
      enable = true;
    };
  };
}
