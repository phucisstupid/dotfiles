_: {
  den.aspects.cli.fzf = {
    homeManager = {
      programs.fzf = {
        enable = true;
        tmux.enableShellIntegration = true;
        defaultOptions = [
          "--height 40%"
          "--border"
        ];
      };
    };
  };
}
