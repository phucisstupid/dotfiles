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
  options.${namespace}.graphical.apps.zathura.enable = lib.mkEnableOption "zathura";
  config = lib.mkIf config.${namespace}.graphical.apps.zathura.enable {
    programs.zathura = {
      enable = true;
    };
  };
}
