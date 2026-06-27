{flake, ...}: {
  den.aspects.tools.git = {
    homeManager = {
      programs.git = {
        enable = true;
        settings = {
          user = {
            inherit (flake.config.me) name;
            inherit (flake.config.me) email;
          };
          init.defaultBranch = "main";
          credential.helper = "osxkeychain";
        };
      };
    };

    delta = {
      homeManager = {
        programs.delta = {
          enable = true;
          enableGitIntegration = true;
          options = {
            line-numbers = true;
            hyperlinks = true;
          };
        };
      };
    };

    gh = {
      homeManager = {
        programs.gh = {
          enable = true;
        };
      };
    };

    gh-dash = {
      homeManager = {
        programs.gh-dash = {
          enable = true;
        };
      };
    };

    lazygit = {
      homeManager = {
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
                pager = "delta --paging=never --line-numbers --hyperlinks --hyperlinks-file-link-format=\"lazygit-edit://{path}:{line}\"";
              }
              {}
            ];
          };
        };
      };
    };
  };
}
