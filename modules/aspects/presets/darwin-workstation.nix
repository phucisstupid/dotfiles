{den, ...}: {
  den.aspects.darwin-workstation = {
    includes = with den.aspects; [
      darwin-common
      home-manager
      macos-defaults
      darwin-shells
    ];

    _.to-users.includes = with den.aspects; [
      git
      cli
      fish
      starship
      ghostty
      tmux
      lazyvim
      catppuccin
      aerospace
    ];
  };
}
