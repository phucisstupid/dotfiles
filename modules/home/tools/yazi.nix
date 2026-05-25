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
        // lib.optionalAttrs config.${namespace}.tools.git.lazygit.enable {inherit lazygit;};
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
