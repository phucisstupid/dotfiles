_: {
  den.aspects.app.obs-studio = {
    homeManager =
      { lib, pkgs, ... }:
      lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
        programs.obs-studio = {
          enable = true;
        };
      };
  };
}
