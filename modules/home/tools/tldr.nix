{
  config,
  pkgs,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.tools.tldr.enable = lib.mkEnableOption "tldr";
  config = lib.mkIf config.${namespace}.tools.tldr.enable {
    home.packages = with pkgs; [tlrc];
    services.tldr-update = {
      enable = true;
      package = pkgs.tlrc;
    };
  };
}
