{
  config,
  lib,
  flake,
  ...
}: {
  options.${flake.config.me.namespace}.graphical.browsers.zen-browser.enable =
    lib.mkEnableOption "zen-browser";
  config = lib.mkIf config.${flake.config.me.namespace}.graphical.browsers.zen-browser.enable {
    # programs.zen-browser = {
    #   enable = true;
    # };
  };
}
