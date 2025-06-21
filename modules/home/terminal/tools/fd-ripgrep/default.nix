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
  config.programs = lib.mkMerge [
    (lib.mkIf config.${namespace}.terminal.tools.fd.enable {
      fd = {
        enable = true;
        hidden = true;
        ignores = [
          ".git/"
          "*.bak"
        ];
      };
    })
    (lib.mkIf config.${namespace}.terminal.tools.ripgrep.enable {
      ripgrep = {
        enable = true;
        arguments = [
          "--max-columns=150"
          "--max-columns-preview"
          "--hidden"
          "--glob=!.git/*"
          "--smart-case"
        ];
      };
    })
  ];
}
