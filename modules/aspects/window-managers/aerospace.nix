_: let
  mod = "alt";
  aerospace = {
    homeManager = {lib, ...}: {
      services.jankyborders = {
        enable = true;
        settings = {
          active_color = "0xffcba6f7";
          hidpi = "on";
        };
      };
      programs.aerospace = {
        enable = true;
        launchd.enable = true;
        settings = {
          key-mapping = {
            preset = "colemak";
            key-notation-to-key-code = {
              g = "b";
              d = "g";
              h = "m";
              z = "x";
              x = "c";
              c = "d";
              b = "z";
              m = "h";
            };
          };
          default-root-container-layout = "tiles";
          automatically-unhide-macos-hidden-apps = true;
          exec-on-workspace-change = [
            "/bin/bash"
            "-c"
          ];
          on-focus-changed = ["move-mouse window-lazy-center"];
          gaps = {
            inner = {
              horizontal = 3;
              vertical = 3;
            };
            outer = {
              top = 2;
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
                ]) (lib.range 1 6)
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
              "if".app-name-regex-substring = "tv|music|spotify|stremio|netflix";
              run = "move-node-to-workspace 5";
            }
            {
              "if".app-name-regex-substring = "codex|opencode";
              run = "move-node-to-workspace 6";
            }
          ];
        };
      };
    };
  };
in {
  den.aspects.aerospace.includes = [aerospace];
}
