{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.tools.spotify-player.enable = lib.mkEnableOption "spotify-player";
  config = lib.mkIf config.${namespace}.tools.spotify-player.enable {
    programs.spotify-player = {
      enable = true;
    };
  };
}
