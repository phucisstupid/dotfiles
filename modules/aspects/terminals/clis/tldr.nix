{pkgs, ...}: {
  den.aspects.terminal.cli.tldr = {
    homeManager = {
      programs.tealdeer = {
        enable = true;
        enableAutoUpdates = true;
      };
    };
  };
}
