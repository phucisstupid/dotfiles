{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.editors.helix.enable = lib.mkEnableOption "helix";
  config.programs.helix = {
    inherit (config.${namespace}.editors.helix) enable;
    defaultEditor = true;
    settings.editor = {
      line-number = "relative";
      cursor-shape.insert = "bar";
    };
  };
}
