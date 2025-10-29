{flake, ...}: let
  inherit (flake) config inputs;
  inherit
    (inputs)
    self
    catppuccin
    stylix
    lazyvim
    nvf
    nix4nvchad
    spicetify-nix
    ;
in {
  imports = [
    {
      users.users.${config.me.username}.home = "/Users/${config.me.username}";
      system.primaryUser = config.me.username;
      home-manager = {
        users.${config.me.username} = {};
        sharedModules = [
          self.homeModules.default
          catppuccin.homeModules.catppuccin
          stylix.homeModules.stylix
          lazyvim.homeManagerModules.lazyvim
          nvf.homeManagerModules.default
          nix4nvchad.homeManagerModules.default
          spicetify-nix.homeManagerModules.spicetify
        ];
      };
    }
  ];
}
