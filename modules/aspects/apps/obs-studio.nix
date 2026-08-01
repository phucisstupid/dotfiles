_: {
  den.aspects.app.obs-studio = {
    homeManager = {pkgs, ...}: {
      programs.obs-studio = {
        enable = true;
      };
    };
  };
}
