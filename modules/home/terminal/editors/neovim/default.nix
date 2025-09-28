{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    extraPackages = [pkgs.cargo];
  };
}
