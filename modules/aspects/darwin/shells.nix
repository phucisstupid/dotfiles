# System shells for Darwin.
{ pkgs, ...}: let
  fish = {
    darwin = {
      programs.fish.enable = true;
      environment.shells = [pkgs.fish];
    };
  };
in {
  den.aspects.darwin-shells.includes = [fish];
}
