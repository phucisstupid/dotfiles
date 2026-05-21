# Optional CLI tool aspects.
{den, ...}: let
  perUser = homeManager: den.lib.perUser {inherit homeManager;};
in {
  den.aspects.broot.includes = [
    (perUser {
      programs.broot.enable = true;
    })
  ];

  den.aspects.clock-rs.includes = [
    (perUser {
      programs.clock-rs = {
        enable = true;
        settings = {
          general = {
            color = "magenta";
            interval = 250;
            blink = true;
            bold = true;
          };
          position = {
            horizontal = "center";
            vertical = "center";
          };
          date = {
            fmt = "%A, %B %d, %Y";
            use_12h = true;
            utc = true;
            hide_seconds = true;
          };
        };
      };
    })
  ];

  den.aspects.spotify-player.includes = [
    (perUser {
      programs.spotify-player.enable = true;
    })
  ];

  den.aspects.btop.includes = [
    (perUser {
      programs.btop = {
        enable = true;
        settings.vim_keys = true;
      };
    })
  ];

  den.aspects.bottom.includes = [
    (perUser {
      programs.bottom.enable = true;
    })
  ];

  den.aspects.navi.includes = [
    (perUser {
      programs.navi = {
        enable = true;
        settings.client.tealdeer = true;
      };
    })
  ];

  den.aspects.fastfetch.includes = [
    (perUser {
      programs.fastfetch = {
        enable = true;
        settings = {
          display.separator = " :: ";
          modules = [
            "title"
            "separator"
            "os"
            "host"
            "kernel"
            "uptime"
            "packages"
            "shell"
            "terminal"
            "cpu"
            "gpu"
            "memory"
            "disk"
            "break"
            "colors"
          ];
        };
      };
    })
  ];
}
