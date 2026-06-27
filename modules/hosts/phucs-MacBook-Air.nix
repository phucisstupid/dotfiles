{den, ...}: let
  hostName = "phucs-MacBook-Air";
  system = "aarch64-darwin";
in {
  flake-file.inputs.darwin.url = "github:nix-darwin/nix-darwin";

  den.hosts.${system}.${hostName}.users = {
    wow.classes = ["homeManager"];
  };

  den.aspects.wow.includes = [den.batteries.host-aspects];

  den.aspects.${hostName} = {
    darwin = {
      system.stateVersion = 7;
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
      editors.neovim.lazyvim
      terminals.emulators.ghostty
      shells
      shells.fish
      shells.prompts.starship
      wms.aerospace
      tools.nh
      tools.fzf
      tools.git.lazygit
      tools.eza
      themes.catppuccin
    ];
  };
}
