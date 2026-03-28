{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.tools.carapace.enable = lib.mkEnableOption "carapace";
  config = lib.mkIf config.${namespace}.tools.carapace.enable {
    programs.carapace.enable = true;
  };
}
