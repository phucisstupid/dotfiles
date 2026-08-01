{
  den,
  lib,
  ...
}: {
  den.aspects.cli.yazi = {host, ...}: let
    hasLazygit = host.hasAspect den.aspects.cli.lazygit;
  in {
    homeManager = {pkgs, ...}: {
      programs.yazi = {
        enable = true;
        plugins = with pkgs.yaziPlugins;
          {
            inherit
              git
              mount
              chmod
              toggle-pane
              smart-enter
              ;
          }
          // lib.optionalAttrs hasLazygit {inherit lazygit;};
        initLua = ''
          require("git"):setup({
           order = 1500,
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
              url = "*";
              run = "git";
              group = "git";
            }
            {
              url = "*/";
              run = "git";
              group = "git";
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
          ]
          ++ lib.optionals hasLazygit [
            {
              on = [
                "g"
                "i"
              ];
              run = "plugin lazygit";
            }
          ];
      };
    };
  };
}
