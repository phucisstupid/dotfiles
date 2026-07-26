{den, ...}: {
  den.aspects.terminal.cli.bat = {host, ...}: let
    hasRipgrep = host.hasAspect den.aspects.terminal.cli.ripgrep;
  in {
    homeManager = {
      pkgs,
      lib,
      ...
    }: {
      programs.bat = {
        enable = true;
        extraPackages = lib.mkIf hasRipgrep [pkgs.bat-extras.batgrep];
      };
      home.shellAliases = lib.mkIf hasRipgrep {
        rg = "batgrep";
      };
    };
  };
}
