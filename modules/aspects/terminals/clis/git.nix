_: {
  den.aspects.terminal.cli.git = {user, ...}: {
    homeManager = {
      programs.git = {
        enable = true;
        settings = {
          user = {
            name = user.fullName;
            inherit (user) email;
          };
          init.defaultBranch = "main";
          credential.helper = "osxkeychain";
        };
      };
    };
  };
}
