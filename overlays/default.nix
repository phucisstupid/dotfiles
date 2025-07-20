{flake, ...}: let
  inherit (flake) inputs;
in
  inputs.brew-nix.overlays.default
