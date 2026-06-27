{
  config,
  pkgs,
  lib,
  ...
}: {
  den.aspects.tools.bat = {
    homeManager = {
      programs.bat = {
        enable = true;
        extraPackages = lib.mkIf config.den.aspects.tools.ripgrep.enable [pkgs.bat-extras.batgrep];
      };
      home.shellAliases = lib.mkIf config.den.aspects.tools.ripgrep.enable {
        rg = "batgrep";
      };
    };
  };
}
