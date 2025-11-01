{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.browsers.qutebrowser.enable = lib.mkEnableOption "qutebrowser";
  config = lib.mkIf config.${namespace}.browsers.qutebrowser.enable {
    programs.qutebrowser = {
      enable = true;
      settings = {
        window.hide_decoration = true;
      };
    };
  };
}
