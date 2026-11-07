{
  den.aspects.window-manager.hyprland = {
    nixos = {
      programs.hyprland = {
        enable = true;
        withUWSM = true;
      };
    };

    homeManager = {
      wayland.windowManager.hyprland = {
        enable = true;
      };
    };

    hyprlock = {
      nixos = {
        security.pam.services.hyprlock = { };
      };

      homeManager = {
        catppuccin.hyprlock.useDefaultConfig = false;

        programs.hyprlock = {
          enable = true;
          settings = {
            general = {
              ignore_empty_input = true;
            };

            animations = {
              enabled = false;
            };

            background = {
              monitor = "";
              color = "$base";
              path = "screenshot";
              blur_passes = 3;
            };

            input-field = {
              monitor = "";
              size = "650, 100";
              position = "0, 0";
              halign = "center";
              valign = "center";

              inner_color = "rgba($baseAlphacc)";
              outer_color = "$text";
              outline_thickness = 4;

              font_family = "Maple Mono NF";
              font_color = "$text";

              placeholder_text = "Enter Password";
              check_color = "$accent";
              fail_color = "$red";
              fail_text = "<i>$FAIL ($ATTEMPTS)</i>";

              rounding = 0;
              shadow_passes = 0;
              fade_on_empty = false;
            };

            auth = {
              "fingerprint:enabled" = false;
            };
          };
        };
      };
    };

    hypridle = {
      homeManager = {
        services.hypridle = {
          enable = true;
          settings = {
            general = {
              lock_cmd = "pidof hyprlock || hyprlock";
              before_sleep_cmd = "loginctl lock-session";
              after_sleep_cmd = "sleep 1 && hyprctl dispatch dpms on";
              inhibit_sleep = 3;
            };

            listener = [
              {
                timeout = 150;
                on-timeout = "loginctl lock-session";
              }
              {
                timeout = 330;
                on-timeout = "brightnessctl -sd '*::kbd_backlight' set 0";
                on-resume = "brightnessctl -rd '*::kbd_backlight'";
              }
              {
                timeout = 330;
                on-timeout = "hyprctl dispatch dpms off";
                on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
              }
            ];
          };
        };
      };
    };

    hyprpolkitagent = {
      homeManager = {
        services.hyprpolkitagent.enable = true;
        catppuccin.hyprtoolkit.enable = true;
      };
    };
  };
}
