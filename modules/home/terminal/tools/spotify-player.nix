{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.terminal.tools.spotify-player.enable = lib.mkEnableOption "spotify-player";
  config = lib.mkIf config.${namespace}.terminal.tools.spotify-player.enable {
    programs.spotify-player = {
      enable = true;
    };
  };
}
