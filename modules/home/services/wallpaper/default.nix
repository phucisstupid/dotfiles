{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
  inherit (flake) inputs;
in {
  options.${namespace}.services.wallpaper.enable = lib.mkEnableOption "wallpaper";
  config = lib.mkIf config.${namespace}.services.wallpaper.enable {
    home.file."wallpaper".source = inputs.wallpaper;
  };
}
