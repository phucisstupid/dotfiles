{
  flake,
  inputs,
  ...
}: let
  inherit (flake) config inputs;
  inherit
    (inputs)
    self
    mac-app-util
    catppuccin
    lazyvim
    nix4nvchad
    spicetify-nix
    ;
in {
  imports = [
    self.nixosModules.common
    self.darwinModules.configuration
    mac-app-util.darwinModules.default
    {
      users.users.${config.me.username}.home = "/Users/${config.me.username}";
      system.primaryUser = config.me.username;
      home-manager = {
        users.${config.me.username} = {};
        sharedModules = [
          self.homeModules.default
          mac-app-util.homeManagerModules.default
          catppuccin.homeModules.catppuccin
          lazyvim.homeManagerModules.lazyvim
          nix4nvchad.homeManagerModules.default
          spicetify-nix.homeManagerModules.spicetify
        ];
      };
    }
  ];
}
