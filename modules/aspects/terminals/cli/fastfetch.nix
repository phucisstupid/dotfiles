{lib, ...}: let
  presetConfig = preset: {
    homeManager = {
      programs.fastfetch = {
        enable = true;
        settings = lib.mkMerge [
          (lib.mkIf (preset == "hyde") {
            display.separator = " : ";
            modules = [
              {
                type = "command";
                key = "  ";
                keyColor = "blue";
                text = "splash=$(hyprctl splash);echo $splash";
              }
              {
                type = "custom";
                format = "┌──────────────────────────────────────────┐";
              }
              {
                type = "chassis";
                key = "  󰇺 Chassis";
                format = "{1} {2} {3}";
              }
              {
                type = "os";
                key = "  󰣇 OS";
                format = "{2}";
                keyColor = "red";
              }
              {
                type = "kernel";
                key = "   Kernel";
                format = "{2}";
                keyColor = "red";
              }
              {
                type = "packages";
                key = "  󰏗 Packages";
                keyColor = "green";
              }
              {
                type = "display";
                key = "  󰍹 Display";
                format = "{1}x{2} @ {3}Hz [{7}]";
                keyColor = "green";
              }
              {
                type = "terminal";
                key = "   Terminal";
                keyColor = "yellow";
              }
              {
                type = "wm";
                key = "  󱗃 WM";
                format = "{2}";
                keyColor = "yellow";
              }
              {
                type = "custom";
                format = "└──────────────────────────────────────────┘";
              }
              "break"
              {
                type = "title";
                key = "  ";
                format = "{6} {7} {8}";
              }
              {
                type = "custom";
                format = "┌──────────────────────────────────────────┐";
              }
              {
                type = "cpu";
                key = "   CPU";
                format = "{1} @ {7}";
                keyColor = "blue";
              }
              {
                type = "gpu";
                key = "  󰊴 GPU";
                format = "{1} {2}";
                keyColor = "blue";
              }
              {
                type = "gpu";
                key = "   GPU Driver";
                format = "{3}";
                keyColor = "magenta";
              }
              {
                type = "memory";
                key = "   Memory ";
                keyColor = "magenta";
              }
              {
                type = "disk";
                key = "  󱦟 OS Age ";
                folders = "/";
                format = "{days} days";
                keyColor = "red";
              }
              {
                type = "uptime";
                key = "  󱫐 Uptime ";
                keyColor = "red";
              }
              {
                type = "custom";
                format = "└──────────────────────────────────────────┘";
              }
              {
                type = "colors";
                paddingLeft = 2;
                symbol = "circle";
              }
              "break"
            ];
          })

          (lib.mkIf (preset == "ml4w") {
            logo = {
              type = "small";
              padding.top = 1;
            };
            display.separator = " ";
            modules = [
              {
                key = "╭───────────╮";
                type = "custom";
              }
              {
                key = "│ {#31} user    {#keys}│";
                type = "title";
                format = "{user-name}";
              }
              {
                key = "│ {#32}󰇅 hname   {#keys}│";
                type = "title";
                format = "{host-name}";
              }
              {
                key = "│ {#33}󰅐 uptime  {#keys}│";
                type = "uptime";
              }
              {
                key = "│ {#34}{icon} distro  {#keys}│";
                type = "os";
              }
              {
                key = "│ {#35} kernel  {#keys}│";
                type = "kernel";
              }
              {
                key = "│ {#36} wm      {#keys}│";
                type = "wm";
              }
              {
                key = "│ {#36}󰇄 desktop {#keys}│";
                type = "de";
              }
              {
                key = "│ {#31} term    {#keys}│";
                type = "terminal";
              }
              {
                key = "│ {#32} shell   {#keys}│";
                type = "shell";
              }
              {
                key = "│ {#33}󰍛 cpu     {#keys}│";
                type = "cpu";
                showPeCoreCount = true;
              }
              {
                key = "│ {#34}󰉉 disk    {#keys}│";
                type = "disk";
                folders = "/";
              }
              {
                key = "│ {#36} memory  {#keys}│";
                type = "memory";
              }
              {
                key = "├───────────┤";
                type = "custom";
              }
              {
                key = "│ {#39} colors  {#keys}│";
                type = "colors";
                symbol = "circle";
              }
              {
                key = "╰───────────╯";
                type = "custom";
              }
            ];
          })

          (lib.mkIf (preset == "jakoolit") {
            display.separator = " 󰑃  ";
            modules = [
              "break"
              {
                type = "os";
                key = " DISTRO";
                keyColor = "yellow";
              }
              {
                type = "kernel";
                key = "│ ├";
                keyColor = "yellow";
              }
              {
                type = "packages";
                key = "│ ├󰏖";
                keyColor = "yellow";
              }
              {
                type = "shell";
                key = "│ └";
                keyColor = "yellow";
              }
              {
                type = "wm";
                key = " DE/WM";
                keyColor = "blue";
              }
              {
                type = "wmtheme";
                key = "│ ├󰉼";
                keyColor = "blue";
              }
              {
                type = "icons";
                key = "│ ├󰀻";
                keyColor = "blue";
              }
              {
                type = "cursor";
                key = "│ ├";
                keyColor = "blue";
              }
              {
                type = "terminalfont";
                key = "│ ├";
                keyColor = "blue";
              }
              {
                type = "terminal";
                key = "│ └";
                keyColor = "blue";
              }
              {
                type = "host";
                key = "󰌢 SYSTEM";
                keyColor = "green";
              }
              {
                type = "cpu";
                key = "│ ├󰻠";
                keyColor = "green";
              }
              {
                type = "gpu";
                key = "│ ├󰻑";
                format = "{2}";
                keyColor = "green";
              }
              {
                type = "display";
                key = "│ ├󰍹";
                keyColor = "green";
                compactType = "original-with-refresh-rate";
              }
              {
                type = "memory";
                key = "│ ├󰾆";
                keyColor = "green";
              }
              {
                type = "swap";
                key = "│ ├󰓡";
                keyColor = "green";
              }
              {
                type = "uptime";
                key = "│ ├󰅐";
                keyColor = "green";
              }
              {
                type = "display";
                key = "│ └󰍹";
                keyColor = "green";
              }
              {
                type = "sound";
                key = " AUDIO";
                format = "{2}";
                keyColor = "magenta";
              }
              {
                type = "player";
                key = "│ ├󰥠";
                keyColor = "magenta";
              }
              {
                type = "media";
                key = "│ └󰝚";
                keyColor = "magenta";
              }
              {
                type = "custom";
                format = "{#90}  {#31}  {#32}  {#33}  {#34}  {#35}  {#36}  {#37}  {#38}  {#39}  {#39}  {#38}  {#37}  {#36}  {#35}  {#34}  {#33}  {#32}  {#31}  {#90} ";
              }
              "break"
            ];
          })
        ];
      };
    };
  };
in {
  den.aspects.terminal.cli.fastfetch = {
    hyde = presetConfig "hyde";
    ml4w = presetConfig "ml4w";
    jakoolit = presetConfig "jakoolit";
  };
}
