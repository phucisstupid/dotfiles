_: {
  den.aspects.status-bar.ashell = {
    homeManager = {
      programs.ashell = {
        enable = true;
        systemd.enable = true;
        settings = {
          position = "Top";
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
              command = "fuzzel";
              on_right_click = "alacritty";
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
            weather_location = "Current";
            weather_indicator = "IconAndTemperature";
          };

          system_info = {
            indicators = [ "Cpu" ];
            interval = 5;
          };

          settings = {
            lock_cmd = "playerctl --all-players pause; swaylock &";
            indicators = [
              "IdleInhibitor"
              "Bluetooth"
              "Network"
              "Audio"
              "Battery"
            ];
            battery_format = "Icon";
            audio_indicator_format = "Icon";
            microphone_indicator_format = "Icon";
            network_indicator_format = "Icon";
            bluetooth_indicator_format = "Icon";
            brightness_indicator_format = "Icon";
          };

          osd = {
            enabled = true;
            show_volume_percentage = true;
            show_brightness_percentage = true;
          };

          appearance = {
            font_name = "Maple Mono NF";
            bar = {
              surface = "solid";
              radius = "none";
              margin = "none";
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
