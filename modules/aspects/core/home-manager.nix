# Home Manager settings and shared external modules.
{
  den,
  inputs,
  ...
}: let
  hostConfig = {
    darwin.home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      backupFileExtension = "backup";
      sharedModules = [
        inputs.catppuccin.homeModules.catppuccin
        inputs.stylix.homeModules.stylix
        inputs.lazyvim.homeManagerModules.lazyvim
        inputs.nvf.homeManagerModules.default
        inputs.nix4nvchad.homeManagerModules.default
        inputs.spicetify-nix.homeManagerModules.spicetify
      ];
    };
  };

  userConfig = {
    homeManager.home.stateVersion = "26.05";
  };
in {
  flake-file.inputs = {
    catppuccin.url = "github:catppuccin/nix";
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lazyvim = {
      url = "github:pfassina/lazyvim-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix4nvchad = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.home-manager.includes = [
    hostConfig
    userConfig
  ];
}
