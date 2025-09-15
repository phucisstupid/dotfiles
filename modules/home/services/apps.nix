{
  config,
  pkgs,
  lib,
  flake,
  ...
}:
let
  inherit (flake.config.me) namespace;
in
{
  options.${namespace}.services = {
    darwin-apps.enable = lib.mkEnableOption "Enable extra applications on Darwin";
    linux-apps.enable = lib.mkEnableOption "Enable extra applications on Linux";
  };
  config = lib.mkMerge [
    # Default apps
    {
      home.packages = with pkgs; [
        maple-mono.variable
        uutils-coreutils-noprefix
      ];
    }
    # Darwin-specific apps
    (lib.mkIf config.${namespace}.services.darwin-apps.enable {
      home.packages = with pkgs; [
        raycast
      ];
    })
    # Linux-specific apps
    (lib.mkIf config.${namespace}.services.linux-apps.enable {
      home.packages = with pkgs; [
        # put linux-only apps here
      ];
    })
  ];
}
