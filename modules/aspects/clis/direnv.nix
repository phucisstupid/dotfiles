_: {
  den.aspects.cli.direnv = {
    homeManager = {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
  };
}
