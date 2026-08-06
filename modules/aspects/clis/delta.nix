_: {
  den.aspects.cli.delta = {
    homeManager = {
      programs.delta = {
        enable = true;
        enableGitIntegration = true;
        enableJujutsuIntegration = true;
        options = {
          navigate = true;
          line-numbers = true;
          hyperlinks = true;
        };
      };

      programs.lazygit.settings.git.diffRenderers = [
        {
          command = ''
            delta --paging=never --line-numbers --hyperlinks --hyperlinks-file-link-format="lazygit-edit://{path}:{line}"
          '';
        }
      ];
    };
  };
}
