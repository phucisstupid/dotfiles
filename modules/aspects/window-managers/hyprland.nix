{ den, lib, ... }:
{
  den.aspects.window-manager.hyprland = {
    includes = [
      ({ host }: if lib.hasSuffix "-linux" host.system then den.aspects.app.vicinae else { })
    ];

    nixos.programs.hyprland = {
      enable = true;
      withUWSM = true;
    };

    homeManager =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      let
        lua = lib.generators.mkLuaInline;
        exec = command: "hl.dsp.exec_cmd(${lib.generators.toLua { } command})";
        terminal = config.home.sessionVariables.TERMINAL or (lib.getExe pkgs.ghostty);
        browser = config.home.sessionVariables.BROWSER or (lib.getExe pkgs.chromium);
        vicinae = lib.getExe config.programs.vicinae.package;
        playerctl = lib.getExe pkgs.playerctl;
        brightnessctl = lib.getExe pkgs.brightnessctl;
        bindMod = key: action: {
          _args = [
            (lua ''mod .. " + ${key}"'')
            (lua action)
          ];
        };
        bindModFlags = key: action: flags: {
          _args = [
            (lua ''mod .. " + ${key}"'')
            (lua action)
            flags
          ];
        };
        bindKey = key: action: {
          _args = [
            key
            (lua action)
          ];
        };
        bindKeyFlags = key: action: flags: {
          _args = [
            key
            (lua action)
            flags
          ];
        };
      in
      lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
        wayland.windowManager.hyprland = {
          enable = true;
          settings = {
            mod._var = "SUPER";

            "01_send_shortcut_once" = {
              name = "send_shortcut_once";
              _var = lua ''
                function(mods, key)
                  return function()
                    hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "down" }))

                    hl.timer(function()
                      hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "up" }))
                    end, { timeout = 50, type = "oneshot" })
                  end
                end
              '';
            };

            "02_active_window_is_terminal" = {
              name = "active_window_is_terminal";
              _var = lua ''
                function()
                  local window = hl.get_active_window()
                  if not window then
                    return false
                  end

                  for _, tag in ipairs(window.tags or {}) do
                    if tag:gsub("%*$", "") == "terminal" then
                      return true
                    end
                  end

                  return false
                end
              '';
            };

            "03_universal_clipboard_shortcut" = {
              name = "universal_clipboard_shortcut";
              _var = lua ''
                function(default_mods, default_key, terminal_mods, terminal_key)
                  return function()
                    if active_window_is_terminal() then
                      send_shortcut_once(terminal_mods, terminal_key)()
                    else
                      send_shortcut_once(default_mods, default_key)()
                    end
                  end
                end
              '';
            };

            "04_niri_workspace_target" = {
              name = "niri_workspace_target";
              _var = lua ''
                function(n)
                  local ids = {}
                  for _, ws in ipairs(hl.get_workspaces() or {}) do
                    if ws.id and ws.id > 0 then
                      local wins = hl.get_workspace_windows(ws)
                      if wins and #wins > 0 then
                        table.insert(ids, ws.id)
                      end
                    end
                  end
                  table.sort(ids)
                  if n <= #ids then
                    return ids[n]
                  end
                  return (ids[#ids] or 0) + 1
                end
              '';
            };

            "05_focus_niri_workspace" = {
              name = "focus_niri_workspace";
              _var = lua ''
                function(n)
                  return function()
                    hl.dispatch(hl.dsp.focus({ workspace = niri_workspace_target(n) }))
                  end
                end
              '';
            };

            "06_move_to_niri_workspace" = {
              name = "move_to_niri_workspace";
              _var = lua ''
                function(n)
                  return function()
                    hl.dispatch(hl.dsp.window.move({ workspace = niri_workspace_target(n), follow = true }))
                  end
                end
              '';
            };

            "07_focus_edge_column" = {
              name = "focus_edge_column";
              _var = lua ''
                function(direction)
                  return function()
                    local workspace = hl.get_active_special_workspace() or hl.get_active_workspace()
                    if not workspace then
                      return
                    end

                    local target, edge
                    for _, window in ipairs(hl.get_workspace_windows(workspace)) do
                      local layout = window.layout
                      local column = layout and layout.column
                      if column and not window.hidden then
                        local index = direction * column.index
                        if not edge or index > edge or (index == edge and window.active) then
                          target, edge = window, index
                        end
                      end
                    end

                    if target then
                      hl.dispatch(hl.dsp.focus({ window = target }))
                    end
                  end
                end
              '';
            };

            window_rule = [
              {
                match.class = "(Alacritty|kitty|com.mitchellh.ghostty|foot|org\\.codeberg\\.dnkl\\.foot|wezterm)";
                tag = "+terminal";
              }
              {
                name = "suppress-maximize-events";
                match.class = ".*";
                suppress_event = "maximize";
              }
              {
                name = "fix-xwayland-drags";
                match = {
                  class = "^$";
                  title = "^$";
                  xwayland = true;
                  float = true;
                  fullscreen = false;
                  pin = false;
                };
                no_focus = true;
              }
            ];

            config = {
              general = {
                layout = "scrolling";
                gaps_in = 0;
                gaps_out = 0;
              }
              //
                lib.optionalAttrs
                  ((config.catppuccin.enable or false) && (config.catppuccin.hyprland.enable or false))
                  {
                    "col.active_border" = lua "colors.accent";
                    "col.inactive_border" = lua "colors.surface0";
                  };
              decoration.shadow.enabled = false;
              misc = {
                disable_hyprland_logo = true;
                disable_splash_rendering = true;
                focus_on_activate = true;
              };
              input.touchpad.natural_scroll = true;
              scrolling = {
                focus_fit_method = 1;
                explicit_column_widths = "0.33333, 0.5, 0.66667";
                wrap_focus = false;
                wrap_swapcol = false;
              };
            };

            bind = [
              # Applications
              (bindMod "Return" (exec terminal))
              (bindMod "SHIFT + Return" (exec browser))
              (bindMod "Space" (exec "${vicinae} toggle"))

              # Universal Shortcuts (Omarchy)
              (bindMod "A" ''send_shortcut_once("CTRL", "A")'')
              (bindMod "C" ''universal_clipboard_shortcut("CTRL", "C", "CTRL SHIFT", "C")'')
              (bindMod "V" ''universal_clipboard_shortcut("CTRL", "V", "CTRL SHIFT", "V")'')
              (bindMod "X" ''send_shortcut_once("CTRL", "X")'')
              (bindMod "Z" ''send_shortcut_once("CTRL", "Z")'')
              (bindMod "SHIFT + Z" ''send_shortcut_once("CTRL SHIFT", "Z")'')
              (bindMod "T" ''universal_clipboard_shortcut("CTRL", "T", "CTRL SHIFT", "T")'')
              (bindMod "N" ''universal_clipboard_shortcut("CTRL", "N", "CTRL SHIFT", "N")'')
              (bindMod "CTRL + V" (exec "${vicinae} deeplink vicinae://launch/clipboard/history"))

              # Audio & Media Controls
              (bindKeyFlags "XF86AudioRaiseVolume"
                ''hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0")''
                {
                  repeating = true;
                  locked = true;
                }
              )
              (bindKeyFlags "XF86AudioLowerVolume"
                ''hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")''
                {
                  repeating = true;
                  locked = true;
                }
              )
              (bindKeyFlags "XF86AudioMute" ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")'' {
                locked = true;
              })
              (bindKeyFlags "XF86AudioMicMute" ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")''
                {
                  locked = true;
                }
              )
              (bindKeyFlags "XF86AudioPlay" (exec "${playerctl} play-pause") {
                locked = true;
              })
              (bindKeyFlags "XF86AudioStop" (exec "${playerctl} stop") {
                locked = true;
              })
              (bindKeyFlags "XF86AudioPrev" (exec "${playerctl} previous") {
                locked = true;
              })
              (bindKeyFlags "XF86AudioNext" (exec "${playerctl} next") {
                locked = true;
              })
              (bindModFlags "XF86AudioNext" (exec "${playerctl} next") {
                long_press = true;
              })
              (bindMod "XF86AudioNext" (exec "${playerctl} position 5+"))

              # Brightness Controls
              (bindKeyFlags "XF86MonBrightnessUp" (exec "${brightnessctl} --class=backlight set +5%") {
                repeating = true;
                locked = true;
              })
              (bindKeyFlags "XF86MonBrightnessDown" (exec "${brightnessctl} --class=backlight set 5%-") {
                repeating = true;
                locked = true;
              })

              # Close Tab / Quit Window
              (bindMod "W" ''universal_clipboard_shortcut("CTRL", "W", "CTRL SHIFT", "W")'')
              (bindMod "Q" "hl.dsp.window.close()")

              # Column & Window Focus
              (bindMod "H" ''hl.dsp.layout("focus l")'')
              (bindMod "J" ''hl.dsp.layout("focus d")'')
              (bindMod "K" ''hl.dsp.layout("focus u")'')
              (bindMod "L" ''hl.dsp.layout("focus r")'')

              # Column & Window Movement
              (bindMod "SHIFT + H" ''hl.dsp.layout("swapcol l")'')
              (bindMod "SHIFT + J" ''hl.dsp.window.move({ direction = "down" })'')
              (bindMod "SHIFT + K" ''hl.dsp.window.move({ direction = "up" })'')
              (bindMod "SHIFT + L" ''hl.dsp.layout("swapcol r")'')

              # First / Last Column
              (bindMod "Home" "focus_edge_column(-1)")
              (bindMod "End" "focus_edge_column(1)")

              # Monitor Focus
              (bindMod "CTRL + H" ''hl.dsp.focus({ monitor = "l" })'')
              (bindMod "CTRL + J" ''hl.dsp.focus({ monitor = "d" })'')
              (bindMod "CTRL + K" ''hl.dsp.focus({ monitor = "u" })'')
              (bindMod "CTRL + L" ''hl.dsp.focus({ monitor = "r" })'')

              # Move Window to Monitor
              (bindMod "SHIFT + CTRL + H" ''hl.dsp.window.move({ monitor = "l", follow = true })'')
              (bindMod "SHIFT + CTRL + J" ''hl.dsp.window.move({ monitor = "d", follow = true })'')
              (bindMod "SHIFT + CTRL + K" ''hl.dsp.window.move({ monitor = "u", follow = true })'')
              (bindMod "SHIFT + CTRL + L" ''hl.dsp.window.move({ monitor = "r", follow = true })'')

              # Workspace Focus & Movement
              (bindMod "U" ''hl.dsp.focus({ workspace = "e+1" })'')
              (bindMod "I" ''hl.dsp.focus({ workspace = "e-1" })'')
              (bindMod "SHIFT + U" ''hl.dsp.window.move({ workspace = "e+1", follow = true })'')
              (bindMod "SHIFT + I" ''hl.dsp.window.move({ workspace = "e-1", follow = true })'')
              (bindMod "Tab" ''hl.dsp.focus({ workspace = "previous" })'')

              # Column Stack Management (Consume / Expel / Promote)
              (bindMod "BracketLeft" ''hl.dsp.layout("consume_or_expel prev")'')
              (bindMod "BracketRight" ''hl.dsp.layout("consume_or_expel next")'')
              (bindMod "Comma" ''hl.dsp.layout("consume")'')
              (bindMod "Period" ''hl.dsp.layout("promote")'')

              # Sizing, Preset Widths & Centering
              (bindMod "R" ''hl.dsp.layout("colresize +conf")'')
              (bindMod "SHIFT + R" ''hl.dsp.layout("colresize -conf")'')
              (bindMod "F" ''hl.dsp.layout("colresize 1.0")'')
              (bindMod "SHIFT + F" ''hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" })'')
              (bindMod "CTRL + C" ''hl.dsp.layout("fit active")'')
              (bindMod "SHIFT + C" ''hl.dsp.layout("fit visible")'')
              (bindModFlags "Minus" ''hl.dsp.layout("colresize -0.1")'' {
                repeating = true;
              })
              (bindModFlags "Equal" ''hl.dsp.layout("colresize +0.1")'' {
                repeating = true;
              })
              (bindModFlags "SHIFT + Minus" "hl.dsp.window.resize({ x = 0, y = -100, relative = true })" {
                repeating = true;
              })
              (bindModFlags "SHIFT + Equal" "hl.dsp.window.resize({ x = 0, y = 100, relative = true })" {
                repeating = true;
              })

              # Session & Power Controls
              (bindMod "SHIFT + E" "hl.dsp.exit()")
              (bindKey "CTRL + ALT + Delete" "hl.dsp.exit()")
              (bindMod "SHIFT + P" ''hl.dsp.dpms({ action = "off" })'')
            ]
            ++ builtins.concatMap (n: [
              (bindMod (toString n) "focus_niri_workspace(${toString n})")
              (bindMod "SHIFT + ${toString n}" "move_to_niri_workspace(${toString n})")
            ]) (lib.range 1 9);
          };
        };
      };

    hyprpolkitagent = {
      homeManager =
        {
          lib,
          options,
          pkgs,
          ...
        }:
        lib.mkIf pkgs.stdenv.hostPlatform.isLinux (
          {
            services.hyprpolkitagent.enable = true;
          }
          // lib.optionalAttrs (options ? catppuccin.hyprtoolkit.enable) {
            catppuccin.hyprtoolkit.enable = true;
          }
        );
    };
  };
}
