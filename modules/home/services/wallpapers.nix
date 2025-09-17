{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
  inherit (flake) inputs;
in {
  options.${namespace}.services.wallpapers.enable = lib.mkEnableOption "wallpapers";
  config = lib.mkIf config.${namespace}.services.wallpapers.enable {
    home.file."wallpapers" = {
      source = inputs.wallpapers;
      recursive = true;
    };
  };
}
