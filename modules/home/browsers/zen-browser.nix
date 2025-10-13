{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.browsers.zen-browser.enable = lib.mkEnableOption "zen-browser";
  config = lib.mkIf config.${namespace}.browsers.zen-browser.enable {
    # programs.zen-browser = {
    #   enable = true;
    # };
  };
}
