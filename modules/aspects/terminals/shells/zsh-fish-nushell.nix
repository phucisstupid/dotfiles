{pkgs, ...}: {
  den.aspects.shells = {
    homeManager = {
      home = {
        shell.enableShellIntegration = true;
        shellAliases = {
          "..." = "cd ../..";
          "...." = "cd ../../..";
        };
      };
    };

    zsh = {
      homeManager = {
        programs.zsh = {
          enable = true;
          autocd = true;
          autosuggestion.enable = true;
          defaultKeymap = "viins";
          syntaxHighlighting.enable = true;
          plugins = with pkgs; [
            {inherit (zsh-fzf-tab) name src;}
          ];
        };
      };
      darwin = {pkgs, ...}: {
        programs.zsh.enable = true;
        environment.shells = [pkgs.zsh];
      };
    };

    fish = {
      homeManager = {
        programs.fish = {
          enable = true;
          preferAbbrs = true;
          interactiveShellInit = ''
            set fish_greeting
            fish_vi_key_bindings
          '';
        };
      };
      darwin = {pkgs, ...}: {
        programs.fish.enable = true;
        environment.shells = [pkgs.fish];
      };
    };

    nushell = {
      homeManager = {
        programs.nushell = {
          enable = true;
          settings = {
            show_banner = false;
            edit_mode = "vi";
          };
        };
      };
      darwin = {pkgs, ...}: {
        programs.nushell.enable = true;
        environment.shells = [pkgs.nushell];
      };
    };
  };
}
