{
  inputs,
  lib,
  ...
}: {
  den.aspects.status-bar.sketchybar = {
    homeManager = {pkgs, ...}: {
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
      programs.aerospace.settings = {
        exec-on-workspace-change = [
          "${lib.getExe pkgs.sketchybar} --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE"
        ];
        on-focus-changed = [
          "exec-and-forget ${lib.getExe pkgs.sketchybar} --trigger aerospace_focus_change"
        ];
        gaps.outer.top = 30;
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
  };
}
