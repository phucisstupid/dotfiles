{
  config,
  pkgs,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
  inherit (flake) inputs;
in {
  options.${namespace}.bars.simple-bar.enable = lib.mkEnableOption "simple-bar";
  config = lib.mkIf config.${namespace}.bars.simple-bar.enable {
    home = {
      packages = with pkgs; [
        # ubersitch # TODO: wait till nixpkgs support this, manual install for now
      ];
      file = {
        "Library/Application Support/Übersicht/widgets/simple-bar" = {
          source = inputs.simple-bar;
        };
        ".simplebarrc".source = ./.simplebarrc;
      };
    };
  };
}
