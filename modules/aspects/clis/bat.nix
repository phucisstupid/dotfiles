_: {
  den.aspects.cli.bat = {
    homeManager = {pkgs, ...}: {
      programs.bat = {
        enable = true;
        extraPackages = with pkgs.bat-extras; [
          batman
        ];
      };

      home.shellAliases = {
        man = "batman";
      };
    };
  };
}
