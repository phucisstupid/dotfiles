{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.terminal.tools.carapace.enable = lib.mkEnableOption "carapace";
  config = lib.mkIf config.${namespace}.terminal.tools.carapace.enable {
    programs.carapace.enable = true;
  };
}
