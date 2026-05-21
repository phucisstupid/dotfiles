# Common nix-darwin host settings.
_: let
  common = {
    darwin = {
      users.users.wow.home = "/Users/wow";
      system.primaryUser = "wow";
      nix.enable = false;
      nixpkgs = {
        hostPlatform = "aarch64-darwin";
        config.allowUnfree = true;
      };
      system.stateVersion = 6;
      security.pam.services.sudo_local = {
        touchIdAuth = true;
        reattach = true;
      };
      home-manager.backupFileExtension = "backup";
    };
  };
in {
  den.aspects.darwin-common.includes = [common];
}
