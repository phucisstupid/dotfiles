{ lib, ... }:
{
  den.aspects.window-manager.hyprland = {
    homeManager =
      let
        lua = lib.generators.mkLuaInline;
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
      {
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

            window_rule = {
              match.class = "(Alacritty|kitty|com.mitchellh.ghostty|foot|org\\.codeberg\\.dnkl\\.foot|wezterm)";
              tag = "+terminal";
            };

            config = {
              general = {
                layout = "scrolling";
                gaps_in = 0;
                gaps_out = 0;
                border_size = 1;
                "col.active_border" = lua "colors.accent";
              };
              scrolling = {
                column_width = 0.5;
                focus_fit_method = 1;
                follow_focus = 1;
                explicit_column_widths = "0.33333, 0.5, 0.66667";
                wrap_focus = false;
                wrap_swapcol = false;
                direction = "right";
              };
            };

            bind = [
              # Applications
              (bindMod "Return" ''hl.dsp.exec_cmd("$TERMINAL")'')
              (bindMod "SHIFT + Return" ''hl.dsp.exec_cmd("$BROWSER")'')

              # Universal Clipboard Shortcuts (Omarchy)
              (bindMod "A" ''send_shortcut_once("CTRL", "A")'')
              (bindMod "C" ''universal_clipboard_shortcut("CTRL", "C", "CTRL SHIFT", "C")'')
              (bindMod "V" ''universal_clipboard_shortcut("CTRL", "V", "CTRL SHIFT", "V")'')
              (bindMod "X" ''send_shortcut_once("CTRL", "X")'')
              (bindMod "CTRL + V" ''hl.dsp.exec_cmd("vicinae deeplink vicinae://launch/clipboard/history")'')

              # Audio & Media Controls
              (bindKeyFlags "XF86AudioRaiseVolume"
                ''hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0")''
                {
                  locked = true;
                }
              )
              (bindKeyFlags "XF86AudioLowerVolume"
                ''hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-")''
                {
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
              (bindKeyFlags "XF86AudioPlay" ''hl.dsp.exec_cmd("playerctl play-pause")'' {
                locked = true;
              })
              (bindKeyFlags "XF86AudioStop" ''hl.dsp.exec_cmd("playerctl stop")'' {
                locked = true;
              })
              (bindKeyFlags "XF86AudioPrev" ''hl.dsp.exec_cmd("playerctl previous")'' {
                locked = true;
              })
              (bindKeyFlags "XF86AudioNext" ''hl.dsp.exec_cmd("playerctl next")'' {
                locked = true;
              })

              # Brightness Controls
              (bindKeyFlags "XF86MonBrightnessUp" ''hl.dsp.exec_cmd("brightnessctl --class=backlight set +10%")''
                {
                  locked = true;
                }
              )
              (bindKeyFlags "XF86MonBrightnessDown"
                ''hl.dsp.exec_cmd("brightnessctl --class=backlight set 10%-")''
                {
                  locked = true;
                }
              )

              # Close Tab / Quit Window
              (bindMod "W" ''universal_clipboard_shortcut("CTRL", "W", "CTRL SHIFT", "W")'')
              (bindModFlags "Q" "hl.dsp.window.close()" {
                repeat = false;
              })

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

              # First / Last Column on Tape
              (bindMod "Home" ''hl.dsp.layout("fit tobeg")'')
              (bindMod "End" ''hl.dsp.layout("fit toend")'')

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
              (bindMod "Page_Down" ''hl.dsp.focus({ workspace = "e+1" })'')
              (bindMod "Page_Up" ''hl.dsp.focus({ workspace = "e-1" })'')
              (bindMod "U" ''hl.dsp.focus({ workspace = "e+1" })'')
              (bindMod "I" ''hl.dsp.focus({ workspace = "e-1" })'')
              (bindMod "SHIFT + Page_Down" ''hl.dsp.window.move({ workspace = "e+1", follow = true })'')
              (bindMod "SHIFT + Page_Up" ''hl.dsp.window.move({ workspace = "e-1", follow = true })'')
              (bindMod "SHIFT + U" ''hl.dsp.window.move({ workspace = "e+1", follow = true })'')
              (bindMod "SHIFT + I" ''hl.dsp.window.move({ workspace = "e-1", follow = true })'')
              (bindMod "Tab" ''hl.dsp.focus({ workspace = "previous" })'')

              # Column Stack Management (Consume / Expel / Promote)
              (bindMod "BracketLeft" ''hl.dsp.window.move({ direction = "left" })'')
              (bindMod "BracketRight" ''hl.dsp.window.move({ direction = "right" })'')
              (bindMod "Comma" ''hl.dsp.window.move({ direction = "left" })'')
              (bindMod "Period" ''hl.dsp.layout("promote")'')

              # Sizing, Preset Widths & Centering
              (bindMod "R" ''hl.dsp.layout("colresize +conf")'')
              (bindMod "SHIFT + R" ''hl.dsp.layout("colresize -conf")'')
              (bindMod "F" ''hl.dsp.layout("colresize 1.0")'')
              (bindMod "SHIFT + F" ''hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" })'')
              (bindMod "CTRL + C" ''hl.dsp.layout("fit active")'')
              (bindMod "SHIFT + C" ''hl.dsp.layout("fit visible")'')
              (bindMod "Minus" ''hl.dsp.layout("colresize -0.1")'')
              (bindMod "Equal" ''hl.dsp.layout("colresize +0.1")'')
              (bindMod "SHIFT + Minus" "hl.dsp.window.resize({ x = 0, y = -100, relative = true })")
              (bindMod "SHIFT + Equal" "hl.dsp.window.resize({ x = 0, y = 100, relative = true })")

              # Floating Mode
              (bindMod "T" ''hl.dsp.window.float({ action = "toggle" })'')

              # Session & Power Controls
              (bindMod "SHIFT + E" "hl.dsp.exit()")
              (bindKey "CTRL + ALT + Delete" "hl.dsp.exit()")
              (bindMod "SHIFT + P" ''hl.dsp.dpms({ action = "off" })'')
            ]
            ++ builtins.concatMap (n: [
              (bindMod (toString n) "hl.dsp.focus({ workspace = ${toString n} })")
              (bindMod "SHIFT + ${toString n}" "hl.dsp.window.move({ workspace = ${toString n}, follow = true })")
            ]) (lib.range 1 9);
          };
        };
      };
  };
}
