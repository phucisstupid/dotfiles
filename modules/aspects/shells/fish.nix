{ ...}: let
  fish = {
    homeManager = {
      home = {
        shell.enableShellIntegration = true;
        shellAliases = {
          "..." = "cd ../..";
          "...." = "cd ../../..";
        };
      };
      programs.fish = {
        enable = true;
        preferAbbrs = true;
        interactiveShellInit = ''
          set fish_greeting
          fish_vi_key_bindings
        '';
      };
    };
  };
in {
  den.aspects.fish.includes = [fish];
}
