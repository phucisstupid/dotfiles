{
  config,
  pkgs,
  lib,
  flake,
  ...
}:
let
  inherit (flake.config.me) namespace;
  inherit (flake) inputs;
in
{
  options.${namespace}.wallpaper.enable = lib.mkEnableOption "wallpaper";
  config = lib.mkIf config.${namespace}.wallpaper.enable {
    home.file."wallpaper".source = inputs.wallpaper;
  };
}
