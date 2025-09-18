{
  config,
  pkgs,
  lib,
  flake,
  ...
}:
let
  inherit (flake.config.me) namespace;
in
{
  options.${namespace}.terminal.tools.bat.enable = lib.mkEnableOption "bat";
  config = with config.${namespace}.terminal.tools; {
    programs.bat = {
      inherit (bat) enable;
      extraPackages = lib.mkIf ripgrep.enable ([ pkgs.bat-extras.batgrep ]);
    };
    home.shellAliases = lib.mkIf ripgrep.enable {
      rg = "batgrep";
    };
  };
}
