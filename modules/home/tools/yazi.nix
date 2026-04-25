{
  config,
  pkgs,
  lib,
  flake,
  ...
}: let
  relativeMotionsKeymap = builtins.genList (n: let
    m = toString (n + 1);
  in {
    on = m;
    run = "plugin relative-motions ${m}";
  })
    9;

  inherit (flake.config.me) namespace;
in {
  options.${namespace}.tools.yazi.enable = lib.mkEnableOption "yazi";
  config = with config.${namespace}.tools; {
    programs.yazi = {
      inherit (yazi) enable;
      plugins = with pkgs.yaziPlugins;
        {
          inherit
            git
            mount
            chmod
            toggle-pane
            smart-enter
            relative-motions
            ;
        }
        // lib.optionalAttrs config.${namespace}.tools.git.lazygit.enable {inherit lazygit;};
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
        ]
        ++ relativeMotionsKeymap
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
