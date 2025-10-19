{
  config,
  pkgs,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
  inherit (flake) inputs;
in {
  options.${namespace}.bars.sketchybar.enable = lib.mkEnableOption "sketchybar";
  config = lib.mkIf config.${namespace}.bars.sketchybar.enable {
    home.packages = with pkgs; [
      sketchybar-app-font
    ];
    programs.sketchybar = {
      enable = true;
      config = {
        source = "${inputs.sketchybar-config}";
        recursive = true;
      };
      extraPackages = with pkgs; [
        aerospace
        imagemagick
        macmon
      ];
    };
    xdg.configFile = {
      "sketchybar/dyn-icon_map.sh".source = "${pkgs.sketchybar-app-font}/bin/icon_map.sh";
      "sketchybar/config.sh".text = ''
        BAR_TRANSPARENCY=false
        COLOR_SCHEME="catppuccin-mocha"
        BAR_LOOK="compact"
      '';
    };
  };
}
