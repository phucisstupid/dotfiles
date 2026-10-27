{ inputs, ... }:
{
  flake-file.inputs.treefmt-nix = {
    url = "github:numtide/treefmt-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  perSystem.treefmt = {
    programs = {
      nixfmt.enable = true;
      deadnix.enable = true;
      statix.enable = true;
      shfmt.enable = true;
    };
    settings.formatter.shfmt.includes = [ "dotfiles" ];
  };
}
