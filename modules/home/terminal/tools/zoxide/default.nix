{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.terminal.tools.zoxide.enable = lib.mkEnableOption "zoxide";
  config = lib.mkIf config.${namespace}.terminal.tools.zoxide.enable {
    programs.zoxide = {
      enable = true;
      options = ["--cmd cd"];
    };
  };
}
