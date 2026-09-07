{lib, ...}: {
  den.aspects.window-manager.niri = {
    homeManager = {
      wayland.windowManager.niri = {
        enable = true;
        settings = {
          # Miscellaneous
          prefer-no-csd = {};
          screenshot-path = null;

          environment = {
            ELECTRON_OZONE_PLATFORM_HINT = "auto";
            QT_QPA_PLATFORM = "wayland";
            QT_QPA_PLATFORMTHEME = "gtk3";
            QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
            XDG_CURRENT_DESKTOP = "niri";
            XDG_SESSION_TYPE = "wayland";
          };

          cursor = {
            xcursor-theme = "capitaine-cursors";
            xcursor-size = 24;
          };

          blur = {
            passes = 2;
            offset = 3.0;
            noise = 0.03;
            saturation = 1.0;
          };

          debug = {
            honor-xdg-activation-with-invalid-serial = {};
          };

          hotkey-overlay = {
            skip-at-startup = {};
          };

          # Input Configuration
          input = {
            keyboard = {
              xkb = {};
              numlock = {};
            };
            touchpad = {
              tap = {};
              natural-scroll = {};
            };
            mouse = {};
            focus-follows-mouse = {};
            workspace-auto-back-and-forth = {};
          };

          # Layout Configuration
          layout = {
            gaps = 16;
            center-focused-column = "never";
            background-color = "transparent";
            preset-column-widths._children = [
              {proportion = 0.33333;}
              {proportion = 0.5;}
              {proportion = 0.66667;}
            ];
            struts = {};
          };

          # Keybindings
          binds =
            {
              # noctalia-shell keybinds
              "Mod+Shift+Escape".show-hotkey-overlay = {};

              # Applications
              "Mod+Return" = {
                _props.hotkey-overlay-title = "Open Terminal: Alacritty";
                spawn = "alacritty";
              };
              "Mod+B" = {
                _props.hotkey-overlay-title = "Open Browser: firefox";
                spawn = "firefox";
              };

              # Noctalia
              "Mod+Shift+Return" = {
                _props.hotkey-overlay-title = "Open Wallpaper Selector: noctalia wallpaper toggle";
                spawn-sh = "noctalia msg panel-toggle wallpaper";
              };
              "Mod+S" = {
                _props.hotkey-overlay-title = "Open Control Center: noctalia controlCenter";
                spawn-sh = "noctalia msg panel-toggle control-center";
              };
              "Mod+Shift+S" = {
                _props.hotkey-overlay-title = "Open Settings: noctalia settings";
                spawn-sh = "noctalia msg settings-toggle";
              };
              "Mod+Ctrl+Return" = {
                _props.hotkey-overlay-title = "Open App Launcher: noctalia launcher";
                spawn-sh = "noctalia msg panel-toggle launcher";
              };
              "Mod+Alt+L" = {
                _props.hotkey-overlay-title = "Lock Screen: noctalia lock";
                spawn-sh = "noctalia msg session lock";
              };
              "Mod+Shift+Q" = {
                _props.hotkey-overlay-title = "Session Menu: noctalia sessionMenu";
                spawn-sh = "noctalia msg panel-toggle session";
              };
              "Mod+E" = {
                _props.hotkey-overlay-title = "File Manager: Nautilus";
                spawn = "nautilus";
              };

              # Media Controls
              "XF86AudioRaiseVolume" = {
                _props.allow-when-locked = true;
                spawn-sh = "noctalia msg volume-up";
              };
              "XF86AudioLowerVolume" = {
                _props.allow-when-locked = true;
                spawn-sh = "noctalia msg volume-down";
              };
              "XF86AudioMute" = {
                _props.allow-when-locked = true;
                spawn-sh = "noctalia msg volume-mute";
              };
              "XF86AudioMicMute" = {
                _props.allow-when-locked = true;
                spawn-sh = "noctalia msg mic-mute";
              };
              "XF86AudioNext" = {
                _props.allow-when-locked = true;
                spawn-sh = "noctalia msg media next";
              };
              "XF86AudioPrev" = {
                _props.allow-when-locked = true;
                spawn-sh = "noctalia msg media previous";
              };
              "XF86AudioPlay" = {
                _props.allow-when-locked = true;
                spawn-sh = "noctalia msg media toggle";
              };
              "XF86AudioPause" = {
                _props.allow-when-locked = true;
                spawn-sh = "noctalia msg media toggle";
              };

              # Brightness Controls
              "XF86MonBrightnessUp" = {
                _props.allow-when-locked = true;
                spawn-sh = "noctalia msg brightness-up";
              };
              "XF86MonBrightnessDown" = {
                _props.allow-when-locked = true;
                spawn-sh = "noctalia msg brightness-down";
              };

              # Window Movement and Focus
              "Mod+Q".close-window = {};

              "Mod+Left".focus-column-left = {};
              "Mod+H".focus-column-left = {};
              "Mod+Right".focus-column-right = {};
              "Mod+L".focus-column-right = {};
              "Mod+Up".focus-window-up = {};
              "Mod+K".focus-window-up = {};
              "Mod+Down".focus-window-down = {};
              "Mod+J".focus-window-down = {};

              "Mod+Ctrl+Left".move-column-left = {};
              "Mod+Ctrl+H".move-column-left = {};
              "Mod+Ctrl+Right".move-column-right = {};
              "Mod+Ctrl+L".move-column-right = {};
              "Mod+Ctrl+Up".move-window-up = {};
              "Mod+Ctrl+K".move-window-up = {};
              "Mod+Ctrl+Down".move-window-down = {};
              "Mod+Ctrl+J".move-window-down = {};

              "Mod+Home".focus-column-first = {};
              "Mod+End".focus-column-last = {};
              "Mod+Ctrl+Home".move-column-to-first = {};
              "Mod+Ctrl+End".move-column-to-last = {};

              "Mod+Shift+Left".focus-monitor-left = {};
              "Mod+Shift+Right".focus-monitor-right = {};
              "Mod+Shift+Up".focus-monitor-up = {};
              "Mod+Shift+Down".focus-monitor-down = {};

              "Mod+Shift+Ctrl+Left".move-column-to-monitor-left = {};
              "Mod+Shift+Ctrl+Right".move-column-to-monitor-right = {};
              "Mod+Shift+Ctrl+Up".move-column-to-monitor-up = {};
              "Mod+Shift+Ctrl+Down".move-column-to-monitor-down = {};
              "Mod+Shift+V".switch-focus-between-floating-and-tiling = {};

              "Mod+BracketLeft".consume-or-expel-window-left = {};
              "Mod+BracketRight".consume-or-expel-window-right = {};

              "Mod+Comma".consume-window-into-column = {};
              "Mod+Period".expel-window-from-column = {};

              "Mod+R".switch-preset-column-width = {};
              "Mod+Shift+R".switch-preset-column-width-back = {};

              "Mod+Ctrl+Shift+R".switch-preset-window-height = {};
              "Mod+Ctrl+R".reset-window-height = {};

              # Workspace Switching
              "Mod+WheelScrollDown" = {
                _props.cooldown-ms = 150;
                focus-workspace-down = {};
              };
              "Mod+WheelScrollUp" = {
                _props.cooldown-ms = 150;
                focus-workspace-up = {};
              };
              "Mod+Ctrl+WheelScrollDown" = {
                _props.cooldown-ms = 150;
                move-column-to-workspace-down = {};
              };
              "Mod+Ctrl+WheelScrollUp" = {
                _props.cooldown-ms = 150;
                move-column-to-workspace-up = {};
              };

              "Mod+WheelScrollRight".focus-column-right = {};
              "Mod+WheelScrollLeft".focus-column-left = {};
              "Mod+Ctrl+WheelScrollRight".move-column-right = {};
              "Mod+Ctrl+WheelScrollLeft".move-column-left = {};

              "Mod+Shift+WheelScrollDown".focus-column-right = {};
              "Mod+Shift+WheelScrollUp".focus-column-left = {};
              "Mod+Ctrl+Shift+WheelScrollDown".move-column-right = {};
              "Mod+Ctrl+Shift+WheelScrollUp".move-column-left = {};

              "Mod+Tab".focus-workspace-previous = {};

              # Layout Controls
              "Mod+Ctrl+F".expand-column-to-available-width = {};
              "Mod+C".center-column = {};
              "Mod+Ctrl+C".center-visible-columns = {};
              "Mod+Minus".set-column-width = "-10%";
              "Mod+Equal".set-column-width = "+10%";
              "Mod+Shift+Minus".set-window-height = "-10%";
              "Mod+Shift+Equal".set-window-height = "+10%";

              # Modes
              "Mod+T".toggle-window-floating = {};
              "Mod+F".maximize-column = {};
              "Mod+Shift+F".fullscreen-window = {};
              "Mod+W".toggle-column-tabbed-display = {};
              "Mod+M".maximize-window-to-edges = {};

              # Screenshots
              "Ctrl+Shift+1".screenshot = {};
              "Ctrl+Shift+2".screenshot-screen = {};
              "Ctrl+Shift+3".screenshot-window = {};

              # Emergency Escape Key
              "Mod+Escape" = {
                _props.allow-inhibiting = false;
                toggle-keyboard-shortcuts-inhibit = {};
              };

              # Exit / Power
              "Ctrl+Alt+Delete".quit = {};
              "Mod+Shift+P".power-off-monitors = {};
              "Mod+O" = {
                _props.repeat = false;
                toggle-overview = {};
              };
            }
            // builtins.listToAttrs (
              builtins.concatMap (n: [
                {
                  name = "Mod+${toString n}";
                  value.focus-workspace = n;
                }
                {
                  name = "Mod+Shift+${toString n}";
                  value.move-column-to-workspace = n;
                }
              ]) (lib.range 1 9)
            );

          # Window & Layer Rules
          _children = [
            {
              window-rule = {
                geometry-corner-radius = 20;
                clip-to-geometry = true;
              };
            }
            {
              window-rule = {
                background-effect = {
                  blur = true;
                  xray = false;
                };
              };
            }
            {
              window-rule = {
                match._props.app-id = "dev.noctalia.Noctalia";
                open-floating = true;
                default-column-width.fixed = 1080;
                default-window-height.fixed = 920;
              };
            }
            {
              window-rule = {
                match._props.app-id = "steam";
                exclude._props.title = "^[Ss]team$";
                open-floating = true;
              };
            }
            {
              window-rule = {
                match._props = {
                  app-id = "steam";
                  title = "^notificationtoasts_\\d+_desktop$";
                };
                default-floating-position._props = {
                  x = 10;
                  y = 10;
                  relative-to = "bottom-right";
                };
                open-focused = false;
              };
            }
            {
              layer-rule = {
                match._props.namespace = "^noctalia-wallpaper";
                place-within-backdrop = true;
              };
            }
            {
              layer-rule = {
                match._props.namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$";
                background-effect.xray = false;
              };
            }
          ];
        };
      };
    };
  };
}
