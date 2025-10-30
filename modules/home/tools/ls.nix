{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake.config.me) namespace;
in {
  options.${namespace}.tools.ls = lib.mkOption {
    type = lib.types.nullOr (lib.types.enum ["eza" "lsd"]);
    default = null;
    description = "Choose which ls replacement to use (eza or lsd).";
  };

  config.programs = with config.${namespace}.tools; {
    eza = lib.mkIf (ls == "eza") {
      enable = true;
      git = true;
      icons = "auto";
      colors = "auto";
      extraOptions = ["--group-directories-first"];
    };
    lsd = lib.mkIf (ls == "lsd") {
      enable = true;
    };
  };
}
