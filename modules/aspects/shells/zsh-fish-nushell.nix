{den,...}: {
  den.aspects.shell = {
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
      includes = with den.aspects; [
        shell
        (den.batteries.user-shell "zsh")
      ];
      homeManager = {pkgs, ...}: {
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
    };

    fish = {
      includes = with den.aspects; [
        shell
        (den.batteries.user-shell "fish")
      ];
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
    };

    nushell = {
      includes = with den.aspects; [
        shell
        (den.batteries.user-shell "nushell")
      ];
      homeManager = {
        programs.nushell = {
          enable = true;
          settings = {
            show_banner = false;
            edit_mode = "vi";
          };
        };
      };
    };
  };
}
