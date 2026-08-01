_: {
  den.aspects.cli.jujutsu = {user, ...}: {
    homeManager = {
      programs.jujutsu = {
        enable = true;
        settings = {
          user = {
            name = user.fullName;
            inherit (user) email;
          };
        };
      };
    };
  };
}
