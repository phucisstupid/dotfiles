{
  flake,
  ...
}:
{
  programs.neovim = {
    defaultEditor = true;
    viAlias = true;
  };
}
