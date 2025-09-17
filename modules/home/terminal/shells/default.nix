{
  config,
  pkgs,
  flake,
  lib,
  ...
}:
let
  inherit (flake.config.me) namespace;
in
{
  options.${namespace}.terminal.shells = {
    zsh.enable = lib.mkEnableOption "zsh";
    fish.enable = lib.mkEnableOption "fish";
    nushell.enable = lib.mkEnableOption "nushell";
  };
  config = {
    home = {
      shell.enableShellIntegration = true;
      shellAliases = {
        "..." = "cd ../..";
        "...." = "cd ../../..";
      };
    };
    programs = {
      zsh = {
        inherit (config.${namespace}.terminal.shells.zsh) enable;
        autocd = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        plugins = with pkgs; [
          { inherit (zsh-fzf-tab) name src; }
          { inherit (zsh-vi-mode) name src; }
        ];
      };
      fish = {
        inherit (config.${namespace}.terminal.shells.fish) enable;
        preferAbbrs = true;
        interactiveShellInit = ''
          set fish_greeting
          fish_vi_key_bindings
        '';
        plugins = with pkgs; [
          { inherit (fishPlugins.fzf-fish) name src; }
        ];
      };
      nushell = {
        inherit (config.${namespace}.terminal.shells.nushell) enable;
        settings = {
          show_banner = false;
          edit_mode = "vi";
        };
      };
    };
  };
}
