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
    nix-homebrew
    ;
in {
  imports = [
    self.nixosModules.common
    self.darwinModules.configuration
    self.darwinModules.homebrew
    self.darwinModules.karabiner-elements
    mac-app-util.darwinModules.default
    nix-homebrew.darwinModules.nix-homebrew
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
