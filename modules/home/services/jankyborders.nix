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
  options.${namespace}.services.jankyborders.enable = lib.mkEnableOption "jankyborders";
  config.services.jankyborders = {
    inherit (config.${namespace}.services.jankyborders) enable;
    settings = {
      active_color = "0xffcba6f7";
      hidpi = "on";
    };
  };
}
