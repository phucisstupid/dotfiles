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
  config.programs = with config.${namespace}.terminal.tools; {
    fd = {
      inherit (fd) enable;
      hidden = true;
      ignores = [
        ".git/"
        "*.bak"
      ];
    };
    ripgrep = {
      inherit (ripgrep) enable;
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
