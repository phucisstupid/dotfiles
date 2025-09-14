{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.terminal.tools.atuin.enable = lib.mkEnableOption "atuin";
  config = lib.mkIf config.${namespace}.terminal.tools.atuin.enable {
    programs.atuin = {
      enable = true;
      settings = {
        records = true;
        inline_height = 20;
        enter_accept = true;
        keymap_mode = "vim-insert";
      };
    };
  };
}
