{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.tools.atuin.enable = lib.mkEnableOption "atuin";
  config = lib.mkIf config.${namespace}.tools.atuin.enable {
    programs.atuin = {
      enable = true;
      settings = {
        keymap_mode = "auto";
        inline_height = 20;
      };
    };
  };
}
