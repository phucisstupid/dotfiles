# Configuration common to all Linux systems
{ flake, ... }:
let
  inherit (flake) config inputs;
  inherit (inputs)
    self
    catppuccin
    lazyvim
    nix4nvchad
    spicetify-nix
    lix-module
    ;
in
{
  imports = [
    self.nixosModules.common
    lix-module.nixosModules.default
    {
      users.users.${config.me.username}.isNormalUser = true;
      home-manager = {
        users.${config.me.username} = { };
        sharedModules = [
          self.homeModules.default
          catppuccin.homeModules.catppuccin
          lazyvim.homeManagerModules.lazyvim
          nix4nvchad.homeManagerModules.default
          spicetify-nix.homeManagerModules.spicetify
        ];
      };
    }
  ];
}
