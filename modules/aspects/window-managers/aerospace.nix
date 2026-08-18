{lib, ...}: {
  den.aspects.window-manager.aerospace = {
    homeManager = let
      mod = "alt";
    in {
      programs.aerospace = {
        enable = true;
        launchd.enable = true;
        settings = {
          config-version = 2;

          # colemak-dh
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
          default-root-container-orientation = "auto";
          automatically-unhide-macos-hidden-apps = true;
          exec-on-workspace-change = [
            "/bin/bash"
            "-c"
          ];
          on-focus-changed = ["move-mouse window-lazy-center"];
          on-focused-monitor-changed = ["move-mouse monitor-lazy-center"];
          gaps = {
            inner = {
              horizontal = 0;
              vertical = 0;
            };
            outer = {
              left = 0;
              bottom = 0;
              right = 0;
              top = lib.mkDefault 0;
            };
          };
          mode = {
            main.binding =
              {
                "${mod}-slash" = "layout tiles horizontal vertical";
                "${mod}-comma" = "layout accordion horizontal vertical";
                "${mod}-f" = "fullscreen";
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
              "if".app-name-regex-substring = "wezterm|kitty|ghostty|terminal";
              run = "move-node-to-workspace 2";
            }
            {
              "if".app-name-regex-substring = "chatgpt|opencode|antigravity|claude";
              run = "move-node-to-workspace 3";
            }
            {
              "if".app-name-regex-substring = "libreoffice";
              run = "move-node-to-workspace 4";
            }
            {
              "if".app-name-regex-substring = "tv|music|spotify|stremio|netflix";
              run = "move-node-to-workspace 5";
            }
          ];
        };
      };
    };
  };
}
