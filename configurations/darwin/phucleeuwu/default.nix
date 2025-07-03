{flake, ...}: let
  inherit (flake) inputs;
  inherit (inputs) self;
in {
  imports = [
    self.darwinModules.default
  ];
  networking.hostName = "phucleeuwu";
  nixos-unified.sshTarget = "myuser@myhost";
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 6;
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    reattach = true;
  };
}
