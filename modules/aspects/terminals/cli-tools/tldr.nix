{pkgs, ...}: {
  den.aspects.tools.tldr = {
    homeManager = {
      home.packages = with pkgs; [tlrc];
      services.tldr-update = {
        enable = true;
        package = pkgs.tlrc;
      };
    };
  };
}
