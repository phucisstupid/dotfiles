{ den, ... }:
{
  den.aspects.shell = {
    homeManager =
      { config, ... }:
      {
        home = {
          shell.enableShellIntegration = true;
          sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];
          shellAliases = {
            "..." = "cd ../..";
            "...." = "cd ../../..";
          };
        };

        programs.starship = {
          enable = true;
          enableTransience = true;
          presets = [ "nerd-font-symbols" ];
          settings = {
            character = {
              success_symbol = "[[󰄛](green) ❯](peach)";
              error_symbol = "[[󰄛](red) ❯](peach)";
              vimcmd_symbol = "[󰄛 ❮](subtext1)";
            };
            directory = {
              truncation_length = 4;
              style = "bold lavender";
            };
            git_branch.style = "bold mauve";
            git_metrics.disabled = false;
            battery.display = [
              { threshold = 30; }
            ];
          };
        };
      };

    zsh = {
      includes = [
        den.aspects.shell
        (den.batteries.user-shell "zsh")
      ];
      homeManager =
        { pkgs, ... }:
        {
          programs.zsh = {
            enable = true;
            autocd = true;
            autosuggestion.enable = true;
            defaultKeymap = "viins";
            syntaxHighlighting.enable = true;
            plugins = with pkgs; [
              { inherit (zsh-fzf-tab) name src; }
            ];
          };
        };
    };

    fish = {
      includes = [
        den.aspects.shell
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
      includes = [
        den.aspects.shell
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
