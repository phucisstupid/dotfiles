_: {
  den.aspects.cli.zoxide = {
    homeManager = {
      programs.zoxide = {
        enable = true;
        options = ["--cmd=cd"];
      };
    };
  };
}
