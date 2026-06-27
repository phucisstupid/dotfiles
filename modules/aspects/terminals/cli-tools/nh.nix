_: {
  den.aspects.tools.nh = {
    homeManager = {
      programs.nh = {
        enable = true;
        flake = ../../../..;
        clean.enable = true;
      };
    };
  };
}
