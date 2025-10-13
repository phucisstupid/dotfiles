{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.screenlockers.hyprlock.enable = lib.mkEnableOption "hyprlock";
  config = lib.mkIf config.${namespace}.screenlockers.hyprlock.enable {
    programs.hyprlock = {
      enable = true;
    };
  };
}
