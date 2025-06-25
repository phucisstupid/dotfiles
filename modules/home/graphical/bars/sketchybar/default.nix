{
  config,
  pkgs,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.graphical.bars.sketchybar.enable = lib.mkEnableOption "sketchybar";
  config = lib.mkIf config.${namespace}.graphical.bars.sketchybar.enable {
    home.packages = with pkgs; [
      sketchybar-app-font
      nowplaying-cli
      switchaudio-osx
    ];
    programs.sketchybar = {
      enable = true;
      configType = "lua";
      config = {
        source = ./config;
        recursive = true;
      };
      extraPackages = with pkgs; [
        aerospace
        nowplaying-cli
        switchaudio-osx
      ];
    };
    xdg.configFile = {
      "sketchybar/helpers/icon_map.lua".source = "${pkgs.sketchybar-app-font}/lib/sketchybar-app-font/icon_map.lua";
      "sketchybar/sketchybarrc" = {
        executable = true;
        text = ''
          #!/usr/bin/env lua
          require("helpers")
          require("init")
        '';
      };
    };
  };
}
