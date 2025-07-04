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
  options.${namespace}.graphical.bars.simple-bar.enable = lib.mkEnableOption "simple-bar";
  config = lib.mkIf config.${namespace}.graphical.bars.simple-bar.enable {
    home = {
      packages = with pkgs; [
        brewCasks.ubersicht
      ];
      file = {
        "Library/Application Support/Übersicht/widgets/simple-bar" = {
          source = inputs.simple-bar;
        };
        ".simplebarrc".source = "${inputs.dotfiles-stow}/simple-bar/.simplebarrc";
      };
    };
  };
}
