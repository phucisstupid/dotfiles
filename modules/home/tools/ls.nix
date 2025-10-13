{
  config,
  lib,
  flake,
  ...
}: {
  options.${flake.config.me.namespace}.tools = {
    eza.enable = lib.mkEnableOption "eza";
    lsd.enable = lib.mkEnableOption "lsd";
  };
  config.programs = with config.${flake.config.me.namespace}.tools; {
    eza = {
      inherit (eza) enable;
      git = true;
      icons = "auto";
      colors = "auto";
      extraOptions = ["--group-directories-first"];
    };
    lsd = {
      inherit (lsd) enable;
    };
  };
}
