{
  den,
  lib,
  ...
}: {
  den.aspects.terminal.cli.lazygit = 
    # { host, ... }:
    # let
    #   hasDelta = host.hasAspect den.aspects.terminal.cli.delta;
    # in
    {
      homeManager = {
        programs.lazygit = {
          enable = true;
          settings = {
            gui = {
              expandFocusedSidePanel = true;
              showBottomLine = false;
              nerdFontsVersion = "3";
            };
            git.pagers = 
              # lib.optionals hasDelta 
            [
              {
                pager = ''
                  delta --paging=never --line-numbers --hyperlinks --hyperlinks-file-link-format="lazygit-edit://{path}:{line}"
                '';
              }
            ];
          };
        };
      };
    };
}
