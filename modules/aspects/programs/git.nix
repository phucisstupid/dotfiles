{
  ...
}: let
  git = {
    homeManager = {
      programs.git = {
        enable = true;
        settings = {
          user = {
            name = "phucisstupid";
            email = "125681538+phucisstupid@users.noreply.github.com";
          };
          init.defaultBranch = "main";
          credential.helper = "osxkeychain";
        };
      };

      programs.delta = {
        enable = true;
        enableGitIntegration = true;
        options = {
          line-numbers = true;
          hyperlinks = true;
        };
      };

      programs.gh.enable = true;
      programs.gh-dash.enable = true;

      programs.lazygit = {
        enable = true;
        settings = {
          gui = {
            expandFocusedSidePanel = true;
            showBottomLine = false;
            nerdFontsVersion = "3";
          };
          git.pagers = [
            {
              pager = "delta --paging=never --hyperlinks-file-link-format=\"lazygit-edit://{path}:{line}\"";
            }
          ];
        };
      };
    };
  };
in {
  den.aspects.git.includes = [git];
}
