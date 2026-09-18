{den, ...}: {
  den.aspects.wow = {
    includes = with den.aspects; [
      shell.fish
      shell.prompt.starship
      style.theme.catppuccin
      window-manager.aerospace
      editor.lazyvim
      app.zathura
      terminal.ghostty
      multiplexer.tmux
      multiplexer.tmux.sesh
      cli.git
      cli.gh
      cli.nh
      cli.fzf
      cli.lazygit
      cli.eza
      cli.zoxide
      cli.atuin
      cli.delta
      cli.yazi
      cli.bat
      cli.btop
      cli.carapace
      cli.fd
      cli.ripgrep
      cli.pay-respects
      cli.direnv
      cli.mise
    ];
  };
}
