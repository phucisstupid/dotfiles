{den, ...}: let
  hostName = "phucs-MacBook-Air";
  system = "aarch64-darwin";
in {
  flake-file.inputs.darwin.url = "github:nix-darwin/nix-darwin";

  den.hosts.${system}.${hostName}.users = {
    wow = {};
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
      terminal.cli.git
      terminal.cli.nh
      terminal.cli.fzf
      terminal.cli.lazygit
      terminal.cli.eza
      terminal.cli.zoxide
      terminal.cli.atuin
      terminal.cli.delta
    ];
  };
}
