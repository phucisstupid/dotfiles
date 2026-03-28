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
      configType = "lua";
      config = {
        source = "${inputs.sketchybar-config}";
        recursive = true;
      };
      extraPackages = with pkgs; [
        aerospace
      ];
    };
    xdg.configFile = {
      "sketchybar/helpers/spaces_util/icon_map.lua".source = "${pkgs.sketchybar-app-font}/lib/sketchybar-app-font/icon_map.lua";
      "sketchybar/settings.lua".text = ''
        return {
          bar_preset = "compact",
          window_manager = "aerospace",
          modules = {
            logo = false,
            brew = false,
          },
        }
      '';
    };
  };
}
