_: {
  den.aspects.screenlocker.hyprlock = {
    nixos = { pkgs, ... }: {
      fonts.packages = [ pkgs.maple-mono.NF ];
      security.pam.services.hyprlock = { };
    };

    homeManager =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      let
        brightnessctl = lib.getExe pkgs.brightnessctl;
      in
      lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
        catppuccin.hyprlock.useDefaultConfig = false;

        programs.ashell.settings.settings.lock_cmd =
          lib.mkIf config.programs.ashell.enable "${lib.getExe pkgs.playerctl} --all-players pause; loginctl lock-session";

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

              inner_color = "$surface0";
              outer_color = "$accent";
              outline_thickness = 4;

              font_family = "Maple Mono NF";
              font_color = "$text";

              placeholder_text = "Enter Password";
              check_color = "$accent";
              fail_color = "$red";
              fail_text = "<i>$FAIL ($ATTEMPTS)</i>";
              capslock_color = "$yellow";

              rounding = 0;
              shadow_passes = 0;
              fade_on_empty = false;
            };
          };
        };

        services.hypridle = {
          enable = true;
          settings = {
            general = {
              lock_cmd = "pidof hyprlock || hyprlock";
              before_sleep_cmd = "loginctl lock-session";
              after_sleep_cmd = ''hyprctl dispatch 'hl.dsp.dpms({ action = "enable" })' '';
            };

            listener = [
              {
                timeout = 150;
                on-timeout = "${brightnessctl} -s set 10";
                on-resume = "${brightnessctl} -r";
              }
              {
                timeout = 150;
                on-timeout = "${brightnessctl} -sd '*::kbd_backlight' set 0";
                on-resume = "${brightnessctl} -rd '*::kbd_backlight'";
              }
              {
                timeout = 300;
                on-timeout = "loginctl lock-session";
              }
              {
                timeout = 330;
                on-timeout = ''hyprctl dispatch 'hl.dsp.dpms({ action = "disable" })' '';
                on-resume = ''hyprctl dispatch 'hl.dsp.dpms({ action = "enable" })' && ${brightnessctl} -r'';
              }
              {
                timeout = 1800;
                on-timeout = "systemctl suspend";
              }
            ];
          };
        };
      };
  };
}
