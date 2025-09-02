{flake, ...}: let
  inherit (flake) inputs;
in {
  imports = [
    (inputs.import-tree ../../../modules/darwin)
  ];
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
