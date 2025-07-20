{
  config,
  pkgs,
  lib,
  flake,
  ...
}: {
  options.${flake.config.me.namespace}.graphical.apps.obs-studio.enable = lib.mkEnableOption "obs-studio";
  config = lib.mkIf config.${flake.config.me.namespace}.graphical.apps.obs-studio.enable {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        droidcam-obs
      ];
    };
  };
}
