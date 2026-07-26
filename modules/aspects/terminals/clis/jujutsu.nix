{config, ...}: {
  den.aspects.terminal.cli.jujutsu = {
    homeManager = {
      programs.jujutsu = {
        enable = true;
        settings = {
          user = {
            inherit (config.me) name;
            inherit (config.me) email;
          };
        };
      };
    };
  };
}
