{
  description = "Smartest nix config";
  inputs = {
    # System
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-unified.url = "github:srid/nixos-unified";
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
    mac-app-util.url = "github:hraban/mac-app-util"; # TODO: remove when macOS understands .app files
    brew-api = {
      url = "github:BatteredBunny/brew-api";
      flake = false;
    };
    brew-nix = {
      url = "github:BatteredBunny/brew-nix";
      inputs.brew-api.follows = "brew-api";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lazyvim = {
      url = "github:phucisstupid/LazyVim-module";
      inputs.nixpkgs.follows = "nixpkgs";
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
    wallpaper = {
      url = "github:orangci/walls";
      flake = false;
    };
  };
  outputs = inputs:
    inputs.nixos-unified.lib.mkFlake {
      inherit inputs;
      root = ./.;
    };
}
