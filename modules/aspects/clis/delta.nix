_: {
  den.aspects.cli.delta = {
    homeManager = {
      programs.delta = {
        enable = true;
        enableGitIntegration = true;
        enableJujutsuIntegration = true;
        options = {
          navigate = true;
          line-numbers = true;
          hyperlinks = true;
        };
      };
    };
  };
}
