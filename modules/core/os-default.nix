{
  lib,
  den,
  ...
}: {
  flake-file.inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den = {
    default = {
      nixos.system.stateVersion = "26.05";
      darwin.system.stateVersion = 7;
      homeManager.home.stateVersion = "26.05";

      os = {
        home-manager = {
          useUserPackages = true;
          useGlobalPkgs = true;
          backupFileExtension = "backup";
          overwriteBackup = true;
        };
      };

      includes = with den.batteries; [
        define-user
        hostname
      ];
    };

    # enable homeManager as default for all users
    schema.user.classes = lib.mkDefault ["homeManager"];
  };
}
