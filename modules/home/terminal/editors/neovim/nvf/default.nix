{
  config,
  pkgs,
  lib,
  flake,
  ...
}:
let
  inherit (flake.config.me) namespace;
  inherit (flake) inputs;
in
{
  options.${namespace}.terminal.editors.neovim.nvf.enable = lib.mkEnableOption "neovim.nvf";
  config = lib.mkIf config.${namespace}.terminal.editors.neovim.nvf.enable {
    programs.nvf = {
      enable = true;
      settings = {
        vim.viAlias = true;
        vim.lsp = {
          enable = true;
        };
      };
    };
  };
}
