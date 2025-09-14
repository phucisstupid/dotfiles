{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.terminal.tools.btop.enable = lib.mkEnableOption "btop";
  config = lib.mkIf config.${namespace}.terminal.tools.btop.enable {
    programs.btop = {
      enable = true;
      settings.vim_keys = true;
    };
  };
}
