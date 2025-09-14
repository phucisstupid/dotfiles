{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.graphical.browsers.zen-browser.enable = lib.mkEnableOption "zen-browser";
  config = lib.mkIf config.${namespace}.graphical.browsers.zen-browser.enable {
    # programs.zen-browser = {
    #   enable = true;
    # };
  };
}
