{
  config,
  pkgs,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
  mod = "alt";
in {
  options.${namespace}.wms.aerospace.enable = lib.mkEnableOption "aerospace";
  config = with config.${namespace}; {
    services.jankyborders = {
      inherit (wms.aerospace) enable;
      settings = {
        active_color = "0xffcba6f7";
        hidpi = "on";
      };
    };
    programs.aerospace = {
      inherit (wms.aerospace) enable;
      launchd.enable = true;
      settings = {
        default-root-container-layout = "tiles";
        automatically-unhide-macos-hidden-apps = true;
        exec-on-workspace-change = lib.mkMerge [
          [
            "/bin/bash"
            "-c"
          ]
          (lib.optionals bars.simple-bar.enable [
            "osascript -e 'tell application id \"tracesOf.Uebersicht\" to refresh widget id \"simple-bar-index-jsx\"'"
          ])
          (lib.optionals bars.sketchybar.enable [
            "${lib.getExe pkgs.sketchybar} --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE"
          ])
        ];
        on-focus-changed = lib.mkMerge [
          ["move-mouse window-lazy-center"]
          (lib.optionals bars.simple-bar.enable [
            "exec-and-forget osascript -e 'tell application id \"tracesOf.Uebersicht\" to refresh widget id \"simple-bar-index-jsx\"'"
          ])
          (lib.optionals bars.sketchybar.enable [
            "exec-and-forget ${lib.getExe pkgs.sketchybar} --trigger aerospace_focus_change"
          ])
        ];
        gaps = {
          inner = {
            horizontal = 3;
            vertical = 3;
          };
          outer = {
            top = lib.mkDefault (
              if bars.sketchybar.enable
              then 30
              else if bars.simple-bar.enable
              then 30
              else 2
            );
            bottom = 2;
            left = 2;
            right = 2;
          };
        };
        mode = {
          main.binding =
            {
              "${mod}-slash" = "layout tiles horizontal vertical";
              "${mod}-comma" = "layout accordion horizontal vertical";
              "${mod}-h" = "focus left";
              "${mod}-j" = "focus down";
              "${mod}-k" = "focus up";
              "${mod}-l" = "focus right";
              "${mod}-shift-h" = "move left";
              "${mod}-shift-j" = "move down";
              "${mod}-shift-k" = "move up";
              "${mod}-shift-l" = "move right";
              "${mod}-minus" = "resize smart -50";
              "${mod}-equal" = "resize smart +50";
              "${mod}-tab" = "workspace-back-and-forth";
              "${mod}-shift-tab" = "move-workspace-to-monitor --wrap-around next";
              "${mod}-shift-semicolon" = "mode service";
              "${mod}-shift-f" = "fullscreen --no-outer-gaps";
            }
            // builtins.listToAttrs (
              builtins.concatMap (n: [
                {
                  name = "${mod}-${toString n}";
                  value = "workspace ${toString n}";
                }
                {
                  name = "${mod}-shift-${toString n}";
                  value = "move-node-to-workspace ${toString n}";
                }
              ]) (lib.range 1 5)
            );
          service.binding = {
            "esc" = ["mode main"];
            "b" = [
              "balance-sizes"
              "mode main"
            ];
            "r" = [
              "flatten-workspace-tree"
              "mode main"
            ];
            "f" = [
              "layout floating tiling"
              "mode main"
            ];
            "backspace" = [
              "close-all-windows-but-current"
              "mode main"
            ];
            "${mod}-shift-h" = [
              "join-with left"
              "mode main"
            ];
            "${mod}-shift-j" = [
              "join-with down"
              "mode main"
            ];
            "${mod}-shift-k" = [
              "join-with up"
              "mode main"
            ];
            "${mod}-shift-l" = [
              "join-with right"
              "mode main"
            ];
          };
        };
        on-window-detected = [
          {
            "if".app-name-regex-substring = "zen|safari|helium";
            run = "move-node-to-workspace 1";
          }
          {
            "if".app-name-regex-substring = "preview";
            run = "move-node-to-workspace 2";
          }
          {
            "if".app-name-regex-substring = "bluebook";
            run = "move-node-to-workspace 3";
          }
          {
            "if".app-name-regex-substring = "wezterm|kitty|ghostty|terminal";
            run = "move-node-to-workspace 4";
          }
          {
            "if".app-name-regex-substring = "TV|spotify|stremio|netflix";
            run = "move-node-to-workspace 5";
          }
        ];
      };
    };
  };
}
