{den, ...}: let
  hostName = "phucs-MacBook-Air";
  system = "aarch64-darwin";
in {
  den = {
    hosts.${system}.${hostName}.users = {
      wow = {
        fullName = "phucisstupid";
        email = "125681538+phucisstupid@users.noreply.github.com";
      };
    };

    aspects.${hostName} = {
      darwin = {
        nix.enable = false; # for Determinate Nix
        security.pam.services.sudo_local = {
          touchIdAuth = true;
          reattach = true;
        };
      };

      provides.wow = {
        includes = with den.aspects; [
          style.theme.catppuccin
          window-manager.aerospace
          editor.lazyvim
          app.zathura
          terminal.ghostty
          shell
          shell.fish
          shell.prompt.starship
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
        ];
      };
    };
  };
}
