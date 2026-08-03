{
  den,
  lib,
  ...
}: {
  den.aspects.cli.bat = {host, ...}: let
    hasRipgrep = host.hasAspect den.aspects.cli.ripgrep;
  in {
    homeManager = {pkgs, ...}: {
      programs.bat = {
        enable = true;
        extraPackages = with pkgs.bat-extras;
          (lib.optionals hasRipgrep [batgrep])
          ++ [batman];
      };

      home.shellAliases =
        lib.optionalAttrs hasRipgrep {
          rg = "batgrep";
        }
        // {
          man = "batman";
        };
    };
  };
}
