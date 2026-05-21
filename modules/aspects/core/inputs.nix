# Core flake inputs and dendritic flake modules.
{inputs, ...}: {
  imports = [
    (inputs.flake-file.flakeModules.dendritic or {})
    (inputs.den.flakeModules.dendritic or {})
  ];

  flake-file.inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-file.url = "github:vic/flake-file";
    den.url = "github:vic/den";
    import-tree.url = "github:vic/import-tree";
    flake-parts.url = "github:hercules-ci/flake-parts";
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Temporary while legacy modules are migrated. Task 7 removes this override
  # when generated flake.nix can import the full ./modules tree.
  flake-file.outputs = ''
    inputs:
      inputs.flake-parts.lib.mkFlake { inherit inputs; } {
        imports = [
          (inputs.import-tree ./modules/aspects)
          (inputs.import-tree ./modules/hosts)
          (inputs.import-tree ./modules/users)
        ];
      }
  '';
}
