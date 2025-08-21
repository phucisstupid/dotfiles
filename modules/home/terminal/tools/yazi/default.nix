{
  config,
  pkgs,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
  inherit (flake) inputs;
in {
  options.${namespace}.terminal.tools.yazi.enable = lib.mkEnableOption "yazi";
  config = lib.mkIf config.${namespace}.terminal.tools.yazi.enable {
    programs.yazi = {
      enable = true;
      shellWrapperName = "y"; # TODO: clean when default is fixed
      plugins =
        {
          inherit
            (pkgs.yaziPlugins)
            git
            vcs-files
            mount
            chmod
            full-border
            toggle-pane
            smart-enter
            smart-paste
            yatline
            yatline-catppuccin
            relative-motions
            ;
        }
        // lib.optionalAttrs config.${namespace}.terminal.tools.lazygit.enable {
          inherit (pkgs.yaziPlugins) lazygit;
        };
      initLua = builtins.readFile "${inputs.dotfiles-stow}/yazi/init.lua";
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
            on = [
              "g"
              "c"
            ];
            run = "plugin vcs-files";
          }
          {
            on = "p";
            run = "plugin smart-paste";
          }
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
        ++ builtins.map (n: {
          on = "${toString n}";
          run = "plugin relative-motions ${toString n}";
        }) (lib.range 1 9)
        ++ lib.optionals config.${namespace}.terminal.tools.lazygit.enable [
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
}
