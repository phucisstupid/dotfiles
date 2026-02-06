{
  config,
  pkgs,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.tools.yazi.enable = lib.mkEnableOption "yazi";
  config = with config.${namespace}.tools; {
    programs.yazi = {
      inherit (yazi) enable;
      shellWrapperName = "y"; # TODO: clean when default is fixed
      plugins = with pkgs.yaziPlugins;
        {
          inherit
            git
            mount
            chmod
            full-border
            toggle-pane
            smart-enter
            yatline-catppuccin
            yatline
            relative-motions
            ;
        }
        // lib.optionalAttrs config.${namespace}.tools.git.lazygit.enable {inherit lazygit;};
      initLua = ''
        local catppuccin_theme = require("yatline-catppuccin"):setup("mocha")
        require("full-border"):setup()
        require("git"):setup()
        require("yatline"):setup({
          theme = catppuccin_theme,
        })
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
        ]
        ++ builtins.map (n: {
          on = "${toString n}";
          run = "plugin relative-motions ${toString n}";
        }) (lib.range 1 9)
        ++ lib.optionals git.lazygit.enable [
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
