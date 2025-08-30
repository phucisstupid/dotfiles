{ config, lib, ... }:
let
  inherit (config.flake.config.me) namespace;
in
{
  options.${namespace}.terminal.editors.helix.enable = lib.mkEnableOption "helix";
  config = lib.mkIf config.${namespace}.terminal.editors.helix.enable {
    programs.helix = {
      enable = true;
      defaultEditor = true;
      languages.language = [ { name = "nix"; } ];
      settings.editor = {
        line-number = "relative";
        cursor-shape.insert = "bar";
      };
    };
  };
}
