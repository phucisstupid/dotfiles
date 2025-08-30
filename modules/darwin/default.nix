{flake, ...}: let
  inherit (flake) config inputs;
  inherit
    (inputs)
    self
    catppuccin
    lazyvim
    nvf
    nix4nvchad
    spicetify-nix
    ;
in {
  imports = [
    self.darwinModules.configuration
    {
      users.users.${config.me.username}.home = "/Users/${config.me.username}";
      system.primaryUser = config.me.username;
      home-manager = {
        users.${config.me.username} = {};
        sharedModules = [
          self.homeModules.default
          catppuccin.homeModules.catppuccin
          lazyvim.homeManagerModules.lazyvim
          nvf.homeManagerModules.default
          nix4nvchad.homeManagerModules.default
          spicetify-nix.homeManagerModules.spicetify
        ];
      };
    }
  ];
}
