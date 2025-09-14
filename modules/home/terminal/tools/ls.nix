{
  config,
  lib,
  flake,
  ...
}: {
  options.${flake.config.me.namespace}.terminal.tools = {
    eza.enable = lib.mkEnableOption "eza";
    lsd.enable = lib.mkEnableOption "lsd";
  };
  config.programs = {
    eza = {
      inherit (config.${flake.config.me.namespace}.terminal.tools.eza) enable;
      git = true;
      icons = "auto";
      colors = "auto";
      extraOptions = ["--group-directories-first"];
    };
    lsd = {
      inherit (config.${flake.config.me.namespace}.terminal.tools.lsd) enable;
    };
  };
}
