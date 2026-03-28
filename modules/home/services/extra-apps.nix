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
    extra-linux-apps.enable = lib.mkEnableOption "Enable extra applications on Linux";
  };
  config = lib.mkMerge [
    # Default apps
    {
      home.packages = with pkgs; [
        maple-mono.NF
        uutils-coreutils-noprefix
      ];
    }
    # Darwin-specific apps
    (lib.mkIf config.${namespace}.services.extra-darwin-apps.enable {
      home.packages = with pkgs; [
        raycast
        bitwarden-desktop
      ];
    })
    # Linux-specific apps
    (lib.mkIf config.${namespace}.services.extra-linux-apps.enable {
      home.packages = with pkgs; [
        bitwarden-desktop
      ];
    })
  ];
}
