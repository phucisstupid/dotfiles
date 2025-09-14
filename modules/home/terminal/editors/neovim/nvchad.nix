{
  config,
  lib,
  flake,
  ...
}:
let
  inherit (flake.config.me) namespace;
in
{
  options.${namespace}.terminal.editors.neovim.nvchad.enable = lib.mkEnableOption "nvchad";
  config.programs.nvchad = {
    inherit (config.${namespace}.terminal.editors.neovim.nvchad) enable;
    chadrcConfig = ''
      local M = {}
      M = {
        base46 = { theme = "catppuccin" },
        nvdash = { load_on_startup = true },
      }
      return M
    '';
  };
}
