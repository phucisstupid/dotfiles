{
  inputs,
  lib,
  ...
}:
{
  flake-file.inputs.vicinae-extensions = {
    url = "github:vicinaehq/extensions";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.app.vicinae = {
    homeManager =
      { pkgs, ... }:
      lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
        programs.vicinae = {
          enable = true;
          systemd.enable = true;
          settings = {
            launcher_window = {
              rounding = 0;
            };
          };
          extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
            bluetooth
            wifi-commander
            vscrot
          ];
        };
      };
  };
}
