{
  lib,
  den,
  ...
}: {
  den = {
    default = {
      nixos.system.stateVersion = "26.05";
      darwin.system.stateVersion = 7;
      homeManager.home.stateVersion = "26.05";

      includes = with den.batteries; [
        define-user
        hostname
        inputs'
        den.aspects.home-manager
      ];
    };

    # enable homeManager as default for all users
    schema.user.classes = lib.mkDefault ["homeManager"];
  };
}
