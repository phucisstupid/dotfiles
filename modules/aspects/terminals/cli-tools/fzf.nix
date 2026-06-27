_: {
  den.aspects.tools.fzf = {
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
