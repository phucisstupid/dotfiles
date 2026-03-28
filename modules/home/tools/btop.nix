{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.tools.btop.enable = lib.mkEnableOption "btop";
  config = lib.mkIf config.${namespace}.tools.btop.enable {
    programs.btop = {
      enable = true;
      settings.vim_keys = true;
    };
  };
}
