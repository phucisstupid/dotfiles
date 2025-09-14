{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options."${namespace}".services.jankyborders.enable = lib.mkEnableOption "jankyborders";
  config = lib.mkIf config."${namespace}".services.jankyborders.enable {
    services.jankyborders = {
      enable = true;
      settings = {
        order = "below";
        active_color = "0xffcba6f7";
      };
    };
  };
}
