_: {
  den.aspects.editors.helix = {
    homeManager = {
      programs.helix = {
        enable = true;
        defaultEditor = true;
        settings.editor = {
          line-number = "relative";
          cursor-shape.insert = "bar";
        };
      };
    };
  };
}
