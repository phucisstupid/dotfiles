{
  den,
  ...
}: let
  ghostty = {
    homeManager = {pkgs, ...}: {
      programs.ghostty = {
        enable = true;
        package = pkgs.ghostty-bin;
        settings = {
          font-family = "Maple Mono NF";
          font-size = 17;
          mouse-hide-while-typing = true;
          macos-option-as-alt = true;
          macos-titlebar-style = "hidden";
        };
      };
    };
  };
in {
  den.aspects.ghostty.includes = [ghostty];
}
