_: {
  den.aspects.cli = {
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
      homeManager = {pkgs, ...}: {
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
        programs.bat = {
          extraPackages = with pkgs.bat-extras; [batgrep];
        };
        home.shellAliases = {
          rg = "batgrep";
        };
      };
    };
  };
}
