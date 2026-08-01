{den, ...}: let
  hostName = "phucs-MacBook-Air";
  system = "aarch64-darwin";
in {
  den.hosts.${system}.${hostName}.users = {
    wow = {
      fullName = "phucisstupid";
      email = "phucleeuwu@gmail.com";
    };
  };

  den.aspects.wow.includes = [den.batteries.host-aspects];

  den.aspects.${hostName} = {
    darwin = {
      nix.enable = false; # for Determinate Nix
      security.pam.services.sudo_local = {
        touchIdAuth = true;
        reattach = true;
      };
      users.users.wow = {
        home = "/Users/wow";
      };
    };

    includes = with den.aspects; [
      home-manager
      style.theme.catppuccin
      window-manager.aerospace
      editor.lazyvim
      terminal.emulator.ghostty
      terminal.shell
      terminal.shell.fish
      terminal.shell.prompt.starship
      terminal.multiplexer.tmux
      terminal.multiplexer.tmux.sesh
      terminal.cli.git
      terminal.cli.gh
      terminal.cli.gh-dash
      terminal.cli.jujutsu
      terminal.cli.nh
      terminal.cli.fzf
      terminal.cli.lazygit
      terminal.cli.eza
      terminal.cli.zoxide
      terminal.cli.atuin
      terminal.cli.delta
      terminal.cli.yazi
      terminal.cli.bat
      terminal.cli.btop
      terminal.cli.carapace
      terminal.cli.fd
      terminal.cli.ripgrep
      terminal.cli.pay-respects
    ];
  };
}
