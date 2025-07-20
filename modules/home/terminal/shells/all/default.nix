{
  config,
  lib,
  flake,
  ...
}: {
  imports = [./all.nix];
  options.${flake.config.me.namespace}.terminal.shells = {
    zsh.enable = lib.mkEnableOption "zsh";
    fish.enable = lib.mkEnableOption "fish";
    nushell.enable = lib.mkEnableOption "nushell";
    prompts = {
      starship.enable = lib.mkEnableOption "starship";
      oh-my-posh.enable = lib.mkEnableOption "oh-my-posh";
    };
  };
}
