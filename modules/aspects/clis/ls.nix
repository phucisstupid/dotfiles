_: {
  den.aspects.cli.eza = {
    homeManager = {
      programs.eza = {
        enable = true;
        git = true;
        icons = "auto";
        colors = "auto";
        extraOptions = [
          "--group-directories-first"
          "--hyperlink"
        ];
      };
    };
  };
}
