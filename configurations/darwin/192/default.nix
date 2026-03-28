{flake, ...}: let
  inherit (flake) inputs;
in {
  imports = [
    (inputs.import-tree ../../../modules/darwin)
  ];
  nix.enable = false; # for Determinate Nix
  networking.hostName = "192";
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
}
