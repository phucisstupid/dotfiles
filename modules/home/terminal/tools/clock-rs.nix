{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.terminal.tools.clock-rs.enable = lib.mkEnableOption "clock-rs";
  config = lib.mkIf config.${namespace}.terminal.tools.clock-rs.enable {
    programs.clock-rs = {
      enable = true;
      settings = {
        general = {
          color = "magenta";
          interval = 250;
          blink = true;
          bold = true;
        };
        position = {
          horizontal = "center";
          vertical = "center";
        };
        date = {
          fmt = "%A, %B %d, %Y";
          use_12h = true;
          utc = true;
          hide_seconds = true;
        };
      };
    };
  };
}
