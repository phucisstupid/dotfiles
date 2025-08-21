{ flake, ... }:
let
  inherit (flake) config inputs;
  inherit (inputs)
    self
    catppuccin
    lazyvim
    nix4nvchad
    spicetify-nix
    ;
in
{
  imports = [
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
