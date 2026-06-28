{pkgs, ...}: {
  den.aspects.app.obs-studio = {
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
