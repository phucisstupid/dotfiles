_: {
  den.aspects.terminal.cli.zoxide = {
    homeManager = {
      programs.zoxide = {
        enable = true;
        options = ["--cmd=cd"];
      };
    };
  };
}
