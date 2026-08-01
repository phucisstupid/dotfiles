{
  ...
}: {
  den.aspects.terminal.cli.bat = {
    homeManager = { pkgs, ... }: {
      programs.bat = {
        enable = true;
        extraPackages = with pkgs.bat-extras; [
          batman
          batgrep
        ];
      };

      home.shellAliases = {
        rg = "batgrep";
        man = "batman";
      };
    };
  };
}
