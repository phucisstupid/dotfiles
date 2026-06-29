_: {
  den.aspects.terminal.cli.nh = {
    homeManager = {
      programs.nh = {
        enable = true;
        flake = ../../../..;
        clean.enable = true;
      };
    };
  };
}
