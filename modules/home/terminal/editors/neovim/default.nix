{pkgs, ...}: {
  programs.neovim = {
    defaultEditor = true;
    viAlias = true;
    vimdiffAlias = true;
    # TODO: delete all of this when lazyvim-module fix
    enable = true;
    withNodeJs = true;
    extraPackages = [pkgs.cargo];
  };
}
