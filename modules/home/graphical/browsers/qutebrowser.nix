{
  config,
  lib,
  flake,
  ...
}:
let
  inherit (flake.config.me) namespace;
in
{
  options.${namespace}.graphical.browsers.qutebrowser.enable = lib.mkEnableOption "qutebrowser";
  config = lib.mkIf config.${namespace}.graphical.browsers.qutebrowser.enable {
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
