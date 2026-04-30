{
  config,
  pkgs,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.services = {
    extra-darwin-apps.enable = lib.mkEnableOption "Enable extra applications on Darwin";
  };
  config = lib.mkMerge [
    # Default apps
    {
      home.packages = with pkgs; [
        maple-mono.NF
        bitwarden-desktop
      ];
    }
    # Darwin-specific apps
    (lib.mkIf config.${namespace}.services.extra-darwin-apps.enable {
      home.packages = with pkgs; [
        raycast
      ];
    })
  ];
}
