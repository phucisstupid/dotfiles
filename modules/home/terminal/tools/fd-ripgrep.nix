{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.terminal.tools = {
    fd.enable = lib.mkEnableOption "fd";
    ripgrep.enable = lib.mkEnableOption "ripgrep";
  };
  config.programs = {
    fd = {
      inherit (config.${namespace}.terminal.tools.fd) enable;
      hidden = true;
      ignores = [
        ".git/"
        "*.bak"
      ];
    };
    ripgrep = {
      inherit (config.${namespace}.terminal.tools.ripgrep) enable;
      arguments = [
        "--max-columns=150"
        "--max-columns-preview"
        "--hidden"
        "--glob=!.git/*"
        "--smart-case"
      ];
    };
  };
}
