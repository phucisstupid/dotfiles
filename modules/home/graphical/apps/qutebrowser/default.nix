{
  config,
  lib,
  flake,
  ...
}: {
  options.${flake.config.me.namespace}.graphical.apps.qutebrowser.enable = lib.mkEnableOption "qutebrowser";
  config = lib.mkIf config.${flake.config.me.namespace}.graphical.apps.qutebrowser.enable {
    programs.qutebrowser = {
      enable = true;
      settings = {
        window.hide_decoration = true;
        fonts = {
          default_family = "Maple Mono";
          default_size = 18;
        };
      };
    };
  };
}
