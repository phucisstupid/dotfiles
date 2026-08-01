{lib,den, ...}: {
  den.default = {
    nixos.system.stateVersion = "26.05";
    homeManager.home.stateVersion = "26.05";
    darwin.system.stateVersion = 7;
    includes = [
      den.batteries.define-user
      den.batteries.hostname
      den.batteries.inputs'
    ];
  };

  # enable hm by default
  den.schema.user.classes = lib.mkDefault ["homeManager"];
}
