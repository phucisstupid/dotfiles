{
  lib,
  den,
  ...
}: {
  den.default = {
    nixos.system.stateVersion = "26.05";
    darwin.system.stateVersion = 7;
    homeManager.home.stateVersion = "26.05";

    includes = [
      den.batteries.define-user
      den.batteries.hostname
      den.batteries.inputs'
      den.aspects.home-manager
    ];
  };

  # enable homeManager as default for all users
  den.schema.user.classes = lib.mkDefault ["homeManager"];
}
