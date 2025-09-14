{
  config,
  pkgs,
  lib,
  flake,
  ...
}:
let
  inherit (flake.config.me) namespace;
  inherit (flake) inputs;
in
{
  programs.neovim = {
    defaultEditor = true;
    viAlias = true;
  };
}
