_: {
  den.aspects.tools = {
    fd = {
      homeManager = {
        programs.fd = {
          enable = true;
          hidden = true;
          ignores = [
            ".git/"
            "*.bak"
          ];
        };
      };
    };

    ripgrep = {
      homeManager = {
        programs.ripgrep = {
          enable = true;
          arguments = [
            "--max-columns=150"
            "--max-columns-preview"
            "--hidden"
            "--glob=!.git/*"
            "--smart-case"
          ];
        };
      };
    };
  };
}
