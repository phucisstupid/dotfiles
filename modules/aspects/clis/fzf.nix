{
  den,
  lib,
  ...
}: {
  den.aspects.cli.fzf = {host, ...}: let
    hasAtuin = host.hasAspect den.aspects.cli.atuin;
  in {
    homeManager = {
      programs.fzf =
        {
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
