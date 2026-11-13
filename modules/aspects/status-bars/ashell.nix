{ den, ... }: {
  den.aspects.status-bar.ashell = {
    includes = [ den.aspects.app.vicinae ];

    homeManager =
      { config, lib, ... }:
      {
        programs.ashell = {
          enable = true;
          systemd.enable = true;
          settings = {
            layer = "Top";
            enable_esc_key = true;

            modules = {
              left = [
                "appLauncher"
                "Workspaces"
              ];
              center = [
                "Tempo"
                "Privacy"
                "Notifications"
              ];
              right = [
                "Tray"
                "SystemInfo"
                "Settings"
              ];
            };

            CustomModule = [
              {
                name = "appLauncher";
                icon = "󰣇";
                command = "${lib.getExe config.programs.vicinae.package} toggle";
                on_right_click = "$TERMINAL";
              }
            ];

            workspaces = {
              visibility_mode = "MonitorSpecific";
              enable_workspace_filling = true;
              max_workspaces = 5;
            };

            tempo = {
              clock_format = "%A %H:%M";
              formats = [
                "%A %H:%M"
                "%d %B W%V %Y"
              ];
            };

            system_info = {
              indicators = [ "Cpu" ];
            };

            settings = {
              indicators = [
                "IdleInhibitor"
                "Bluetooth"
                "Network"
                "Audio"
                "Battery"
              ];
              battery_format = "Icon";
            };

            osd = {
              enabled = true;
              show_volume_percentage = true;
              show_brightness_percentage = true;
            };

            appearance = {
              bar = {
                surface = "solid";
                padding = [
                  "none"
                  "xs"
                ];
              };
              primary_color = {
                base = "#cba6f7";
                text = "#1e1e2e";
              };
              success_color = "#a6e3a1";
              warning_color = "#f9e2af";
              danger_color = "#f38ba8";
              text_color = "#cdd6f4";
              workspace_colors = [
                "#cba6f7"
                "#89b4fa"
                "#fab387"
              ];
              background_color = {
                base = "#1e1e2e";
                weak = "#313244";
                strong = "#45475a";
              };
            };
          };
        };
      };
  };
}
