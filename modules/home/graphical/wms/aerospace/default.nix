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
      userSettings = {
        start-at-login = true;
        enable-normalization-flatten-containers = true;
        enable-normalization-opposite-orientation-for-nested-containers = true;
        default-root-container-layout = "tiles";
        default-root-container-orientation = "auto";
        automatically-unhide-macos-hidden-apps = true;
        accordion-padding = 30;
        exec-on-workspace-change = lib.mkMerge [
          [
            "/bin/bash"
            "-c"
          ]
          (lib.optionals config.${namespace}.graphical.bars.simple-bar.enable [
            "osascript -e 'tell application id \"tracesOf.Uebersicht\" to refresh widget id \"simple-bar-index-jsx\"'"
          ])
          (lib.optionals config.${namespace}.graphical.bars.sketchybar.enable [
            "${lib.getExe pkgs.sketchybar} --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE"
          ])
        ];
        on-focus-changed = lib.mkMerge [
          ["move-mouse window-lazy-center"]
          (lib.optionals config.${namespace}.graphical.bars.simple-bar.enable [
            "exec-and-forget osascript -e 'tell application id \"tracesOf.Uebersicht\" to refresh widget id \"simple-bar-index-jsx\"'"
          ])
          (lib.optionals config.${namespace}.graphical.bars.sketchybar.enable [
            "exec-and-forget ${lib.getExe pkgs.sketchybar} --trigger aerospace_focus_change"
          ])
        ];
        gaps = {
          inner = {
            horizontal = 5;
            vertical = 5;
          };
          outer = {
            top = lib.mkDefault (
              if config.${namespace}.graphical.bars.sketchybar.enable
              then 45
              else if config.${namespace}.graphical.bars.simple-bar.enable
              then 30
              else 5
            );
            bottom = 5;
            left = 5;
            right = 5;
          };
        };
        mode = {
          main.binding =
            {
              "alt-slash" = "layout tiles horizontal vertical";
              "alt-comma" = "layout accordion horizontal vertical";
              "alt-h" = "focus left";
              "alt-j" = "focus down";
              "alt-k" = "focus up";
              "alt-l" = "focus right";
              "alt-shift-h" = "move left";
              "alt-shift-j" = "move down";
              "alt-shift-k" = "move up";
              "alt-shift-l" = "move right";
              "alt-minus" = "resize smart -50";
              "alt-equal" = "resize smart +50";
              "alt-tab" = "workspace-back-and-forth";
              "alt-shift-tab" = "move-workspace-to-monitor --wrap-around next";
              "alt-f" = "fullscreen";
              "alt-shift-semicolon" = "mode service";
            }
            // builtins.listToAttrs (
              builtins.concatMap (n: [
                {
                  name = "alt-${toString n}";
                  value = "workspace ${toString n}";
                }
                {
                  name = "alt-shift-${toString n}";
                  value = "move-node-to-workspace ${toString n}";
                }
              ]) (lib.range 1 4)
            );
          service.binding = {
            "esc" = [
              "reload-config"
              "mode main"
            ];
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
        };
        on-window-detected = [
          {
            "if".app-name-regex-substring = "zen|arc|safari|brave";
            run = "move-node-to-workspace 1";
          }
          {
            "if".app-name-regex-substring = "TV|spotify|stremio";
            run = "move-node-to-workspace 2";
          }
          {
            "if".app-name-regex-substring = "bluebook|classin";
            run = "move-node-to-workspace 3";
          }
          {
            "if".app-name-regex-substring = "wezterm|kitty|ghostty|terminal";
            run = "move-node-to-workspace 4";
          }
        ];
      };
    };
  };
}
