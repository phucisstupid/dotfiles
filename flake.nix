{
  outputs = inputs @ {flake-parts,systems,import-tree,...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import systems;
      imports = [(import-tree ./modules/flake)];
    };
  inputs = {
    # System
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-unified.url = "github:srid/nixos-unified";
    import-tree.url = "github:vic/import-tree";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Software
    catppuccin.url = "github:catppuccin/nix";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lazyvim = {
      url = "github:matadaniel/LazyVim-module";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems"; # TODO: delete this soon
    };
    nix4nvchad = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    simple-bar = {
      url = "github:Jean-Tinland/simple-bar";
      flake = false;
    };
    dotfiles-stow = {
      url = "github:phucisstupid/dotfiles-stow";
      flake = false;
    };
    wallpapers = {
      url = "github:phucisstupid/wallpapers";
      flake = false;
    };
  };
}
