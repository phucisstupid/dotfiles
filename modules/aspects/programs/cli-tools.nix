{
  den,
  ...
}: let
  cli = {
    homeManager = {pkgs, ...}: let
      relativeMotionsKeymap =
        builtins.genList (n: let
          m = toString (n + 1);
        in {
          on = m;
          run = "plugin relative-motions ${m}";
        })
        9;
    in {
      programs.yazi = {
        enable = true;
        plugins = with pkgs.yaziPlugins; {
          inherit
            git
            mount
            chmod
            toggle-pane
            smart-enter
            relative-motions
            lazygit
            ;
        };
        initLua = ''
          require("git"):setup()
          require("relative-motions"):setup({
            show_numbers = "relative_absolute",
          })
        '';
        settings = {
          mgr.show_hidden = true;
          preview = {
            max_width = 1500;
            max_height = 1500;
          };
          plugin.prepend_fetchers = [
            {
              id = "git";
              name = "*";
              run = "git";
            }
            {
              id = "git";
              name = "*/";
              run = "git";
            }
          ];
        };
        keymap.mgr.prepend_keymap =
          [
            {
              on = "T";
              run = "plugin toggle-pane max-preview";
            }
            {
              on = "M";
              run = "plugin mount";
            }
            {
              on = "l";
              run = "plugin smart-enter";
            }
            {
              on = [
                "c"
                "m"
              ];
              run = "plugin chmod";
            }
            {
              on = [
                "g"
                "i"
              ];
              run = "plugin lazygit";
            }
          ]
          ++ relativeMotionsKeymap;
      };

      programs.atuin = {
        enable = true;
        settings = {
          keymap_mode = "auto";
          inline_height = 20;
        };
      };

      programs.bat = {
        enable = true;
        extraPackages = [pkgs.bat-extras.batgrep];
      };
      home.shellAliases.rg = "batgrep";

      programs.carapace.enable = true;

      programs.eza = {
        enable = true;
        git = true;
        icons = "auto";
        colors = "auto";
        extraOptions = [
          "--group-directories-first"
          "--hyperlink"
        ];
      };

      programs.fd = {
        enable = true;
        hidden = true;
        ignores = [
          ".git/"
          "*.bak"
        ];
      };

      programs.fzf = {
        enable = true;
        tmux.enableShellIntegration = true;
        defaultOptions = [
          "--height 40%"
          "--border"
        ];
      };

      programs.pay-respects.enable = true;

      programs.ripgrep = {
        enable = true;
        arguments = [
          "--max-columns=150"
          "--max-columns-preview"
          "--hidden"
          "--glob=!.git/*"
          "--smart-case"
        ];
      };

      home.packages = with pkgs; [tlrc];
      services.tldr-update = {
        enable = true;
        package = pkgs.tlrc;
      };

      programs.nh = {
        enable = true;
        flake = ../../..;
        clean.enable = true;
      };

      programs.jujutsu = {
        enable = true;
        settings.user = {
          name = "phucisstupid";
          email = "125681538+phucisstupid@users.noreply.github.com";
        };
      };

      programs.zoxide = {
        enable = true;
        options = ["--cmd=cd"];
      };
    };
  };
in {
  den.aspects.cli.includes = [cli];
}
