{pkgs, ...}: {
  den.aspects.apps.obs-studio = {
    homeManager = {
      programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          droidcam-obs
        ];
      };
    };
  };
}
