{flake, ...}: let
  inherit (flake) inputs;
  inherit (inputs) self;
in {
  imports = [self.darwinModules.default];
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
  };
  nix.enable = false;
  system.stateVersion = 6;
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    reattach = true;
  };
  home-manager.backupFileExtension = "backup";
}
