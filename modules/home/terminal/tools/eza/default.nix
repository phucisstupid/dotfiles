{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.terminal.tools.eza.enable = lib.mkEnableOption "eza";
  config = lib.mkIf config.${namespace}.terminal.tools.eza.enable {
    programs.eza = {
      enable = true;
      git = true;
      icons = "auto";
      colors = "auto";
      extraOptions = ["--group-directories-first"];
    };
  };
}
