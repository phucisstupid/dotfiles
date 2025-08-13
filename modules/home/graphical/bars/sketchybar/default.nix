{
  config,
  pkgs,
  lib,
  flake,
  ...
}:
let
  inherit (flake.config.me) namespace;
  inherit (flake) inputs;
in
{
  options.${namespace}.graphical.bars.sketchybar.enable = lib.mkEnableOption "sketchybar";
  config = lib.mkIf config.${namespace}.graphical.bars.sketchybar.enable {
    home.packages = with pkgs; [
      # sf-symbols # TODO: wait till nixpkgs support this, manual install for now
      sketchybar-app-font
      nowplaying-cli
      switchaudio-osx
    ];
    programs.sketchybar = {
      enable = true;
      configType = "lua";
      config = {
        source = "${inputs.dotfiles-stow}/sketchybar";
        recursive = true;
      };
      extraPackages = with pkgs; [
        aerospace
        nowplaying-cli
        switchaudio-osx
      ];
    };
    xdg.configFile = {
      "sketchybar/helpers/app_icons.lua".source =
        "${pkgs.sketchybar-app-font}/lib/sketchybar-app-font/icon_map.lua";
      "sketchybar/helpers/icon_map.lua".source =
        "${pkgs.sketchybar-app-font}/lib/sketchybar-app-font/icon_map.lua";
    };
  };
}
