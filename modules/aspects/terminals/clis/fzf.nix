{
  den,
  lib,
  ...
}: {
  den.aspects.terminal.cli.fzf = { host, ... }:
    let
      hasAtuin = host.hasAspect den.aspects.terminal.cli.atuin;
    in {
      homeManager = {
        programs.fzf = {
          enable = true;
          tmux.enableShellIntegration = true;
          defaultOptions = [
            "--height 40%"
            "--border"
          ];
        }
        // lib.optionalAttrs hasAtuin {
          historyWidget.command = "";
        };
      };
    };
}
