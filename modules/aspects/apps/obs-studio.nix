_: {
  den.aspects.app.obs-studio = {
    homeManager = {pkgs, ...}: {
      programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          droidcam-obs
        ];
      };
    };
  };
}
