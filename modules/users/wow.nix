{ den, ... }: {
  den.aspects.wow = {
    includes = with den.aspects; [
      shell.fish
      appearance.theme.catppuccin
      (appearance.font {
        name = "Maple Mono NF";
        size = 17;
        package = pkgs: pkgs.maple-mono.NF;
      })
      window-manager.aerospace
      editor.lazyvim
      terminal.default.ghostty
      multiplexer.tmux
      app.spotify
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
