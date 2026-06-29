{
  config,
  pkgs,
  lib,
  ...
}: {
  den.aspects.terminal.cli.bat = {
    homeManager = {
      programs.bat = {
        enable = true;
        extraPackages = lib.mkIf config.den.aspects.terminal.cli.ripgrep.enable [pkgs.bat-extras.batgrep];
      };
      home.shellAliases = lib.mkIf config.den.aspects.terminal.cli.ripgrep.enable {
        rg = "batgrep";
      };
    };
  };
}
