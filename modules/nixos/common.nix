# Common to Linux & darwin
{
  flake,
  pkgs,
  lib,
  ...
}: let
  inherit (flake) config inputs;
  inherit (inputs) self;
in {
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = lib.attrValues self.overlays;
  };
  home-manager.backupFileExtension = "backup";
  nix = {
    settings = {
      max-jobs = "auto";
      trusted-users = [
        "root"
        (
          if pkgs.stdenv.isDarwin
          then config.me.username
          else "@wheel"
        )
      ];
    };
  };
}
