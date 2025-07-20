{
  config,
  pkgs,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.terminal.tools.bat.enable = lib.mkEnableOption "bat";
  config = lib.mkIf config.${namespace}.terminal.tools.bat.enable {
    home.shellAliases.rg = "batgrep";
    programs.bat = {
      enable = true;
      extraPackages = [pkgs.bat-extras.batgrep];
    };
  };
}
