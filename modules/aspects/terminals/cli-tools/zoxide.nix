_: {
  den.aspects.tools.zoxide = {
    homeManager = {
      programs.zoxide = {
        enable = true;
        options = ["--cmd=cd"];
      };
    };
  };
}
