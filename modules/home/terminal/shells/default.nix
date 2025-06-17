{
  config,
  lib,
  flake,
  ...
}: {
  imports = [
    ./all/default.nix
    ./prompts/default.nix
  ];
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
