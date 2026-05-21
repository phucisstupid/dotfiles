# System shells for Darwin.
{den, pkgs, ...}: let
  fish = {
    darwin = {
      programs.fish.enable = true;
      environment.shells = [pkgs.fish];
    };
  };
in {
  den.aspects.darwin-shells.includes = [fish];
}
