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
  options.${namespace}.terminal.editors.neovim.nvchad.enable = lib.mkEnableOption "neovim.nvchad";
  config = lib.mkIf config.${namespace}.terminal.editors.neovim.nvchad.enable {
    programs = {
      neovim = {
        defaultEditor = true;
        viAlias = true;
      };
      nvchad = {
        enable = true;
        chadrcConfig = ''
          local M = {}
          M = {
            base46 = { theme = "catppuccin" },
            nvdash = { load_on_startup = true },
          }
          return M
        '';
      };
    };
  };
}
