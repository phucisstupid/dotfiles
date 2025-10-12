{ pkgs, ... }:
{
  programs.neovim = {
    defaultEditor = true;
    viAlias = true;
  };
}
