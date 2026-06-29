_: {
  den.aspects.terminal.cli.clock-rs = {
    homeManager = {
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
    };
  };
}
