{
  config,
  pkgs,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.graphical.wms.aerospace.enable = lib.mkEnableOption "aerospace";
  config = lib.mkIf config.${namespace}.graphical.wms.aerospace.enable {
    programs.aerospace = {
      enable = true;
      userSettings = lib.mkMerge [
        (lib.mkIf config.${namespace}.graphical.bars.sketchybar.enable {
          exec-on-workspace-change = [
            "/bin/bash"
            "-c"
            "${lib.getExe pkgs.sketchybar} --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE"
          ];
          on-focus-changed = [
            "exec-and-forget ${lib.getExe pkgs.sketchybar} --trigger aerospace_focus_change"
          ];
          gaps.outer.top = 45;
        })
        (lib.mkIf config.${namespace}.graphical.bars.simplebar.enable {
          exec-on-workspace-change = [
            "/bin/bash"
            "-c"
            "osascript -e 'tell application id \"tracesOf.Uebersicht\" to refresh widget id \"simple-bar-index-jsx\"'"
          ];
          on-focus-changed = [
            "exec-and-forget osascript -e 'tell application id \"tracesOf.Uebersicht\" to refresh widget id \"simple-bar-index-jsx\"'"
          ];
          gaps.outer.top = 30;
        })
        {
          start-at-login = true;
          enable-normalization-flatten-containers = true;
          enable-normalization-opposite-orientation-for-nested-containers = true;
          default-root-container-layout = "tiles";
          default-root-container-orientation = "auto";
          automatically-unhide-macos-hidden-apps = true;
          accordion-padding = 40;
          on-focus-changed = ["move-mouse window-lazy-center"];
          gaps = {
            inner = {
              horizontal = 10;
              vertical = 10;
            };
            outer = {
              top = lib.mkDefault 5;
              bottom = 5;
              left = 5;
              right = 5;
            };
          };
          mode.main.binding =
            {
              "alt-h" = "focus left";
              "alt-j" = "focus down";
              "alt-k" = "focus up";
              "alt-l" = "focus right";
              "alt-shift-h" = "move left";
              "alt-shift-j" = "move down";
              "alt-shift-k" = "move up";
              "alt-shift-l" = "move right";
              "alt-tab" = "workspace-back-and-forth";
              "alt-shift-tab" = "move-workspace-to-monitor --wrap-around next";
              "alt-f" = "fullscreen";
              "alt-slash" = "layout tiles horizontal vertical";
              "alt-comma" = "layout accordion horizontal vertical";
              "alt-r" = "mode resize";
              "alt-shift-semicolon" = "mode service";
            }
            // builtins.listToAttrs (
              builtins.concatMap (letter: [
                {
                  name = "alt-${lib.strings.toLower letter}";
                  value = "workspace ${letter}";
                }
                {
                  name = "alt-shift-${lib.strings.toLower letter}";
                  value = "move-node-to-workspace ${letter}";
                }
              ]) (lib.strings.stringToCharacters "1234BET")
            );
          mode.resize.binding = {
            "esc" = "mode main";
            "b" = [
              "balance-sizes"
              "mode main"
            ];
            "minus" = "resize smart -50";
            "equal" = "resize smart +50";
          };
          mode.service.binding = {
            "esc" = [
              "reload-config"
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
            "down" = "volume down";
            "up" = "volume up";
            "shift-down" = [
              "volume set 0"
              "mode main"
            ];
            "alt-shift-h" = [
              "join-with left"
              "mode main"
            ];
            "alt-shift-j" = [
              "join-with down"
              "mode main"
            ];
            "alt-shift-k" = [
              "join-with up"
              "mode main"
            ];
            "alt-shift-l" = [
              "join-with right"
              "mode main"
            ];
          };
          on-window-detected = [
            {
              "if".app-name-regex-substring = "finder";
              run = "move-node-to-workspace E";
            }
            {
              "if".app-name-regex-substring = "wezterm|kitty|ghostty";
              run = "move-node-to-workspace T";
            }
            {
              "if".app-name-regex-substring = "zen|arc|safari";
              run = "move-node-to-workspace B";
            }
            {
              "if".app-name-regex-substring = "spotify";
              run = "move-node-to-workspace 4";
            }
          ];
        }
      ];
    };
  };
}
