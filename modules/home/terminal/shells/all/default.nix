{
  config,
  pkgs,
  flake,
  ...
}: {
  home = {
    shell = {
      enableZshIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };
    shellAliases = {
      "..." = "cd ../..";
      "...." = "cd ../../..";
    };
  };
  programs = {
    zsh = {
      inherit (config.${flake.config.me.namespace}.terminal.shells.zsh) enable;
      autocd = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      plugins = [
        {
          inherit (pkgs.zsh-fzf-tab) name src;
        }
        {
          inherit (pkgs.zsh-vi-mode) name src;
        }
      ];
    };
    fish = {
      inherit (config.${flake.config.me.namespace}.terminal.shells.fish) enable;
      preferAbbrs = true;
      interactiveShellInit = ''
        set fish_greeting
        fish_vi_key_bindings
      '';
      plugins = [
        {
          inherit (pkgs.fishPlugins.fzf-fish) name src;
        }
      ];
    };
    nushell = {
      inherit (config.${flake.config.me.namespace}.terminal.shells.nushell) enable;
      settings = {
        show_banner = false;
        edit_mode = "vi";
      };
      shellAliases = {
        ls = "ls";
        ll = "ls -l";
        la = "ls -a";
        lla = "ls -la";
      };
    };
  };
}
