{flake, ...}: {
  den.aspects.terminal.cli.jujutsu = {
    homeManager = {
      programs.jujutsu = {
        enable = true;
        settings = {
          user = {
            inherit (flake.config.me) name;
            inherit (flake.config.me) email;
          };
        };
      };
    };
  };
}
