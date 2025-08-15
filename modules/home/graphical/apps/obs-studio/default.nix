{
  config,
  pkgs,
  lib,
  flake,
  ...
}:
let
  namespace = flake.config.me.namespace;
in
{
  options.${namespace}.graphical.apps.obs-studio.enable = lib.mkEnableOption "obs-studio";
  config = lib.mkIf config.${namespace}.graphical.apps.obs-studio.enable {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        droidcam-obs
      ];
    };
  };
}
