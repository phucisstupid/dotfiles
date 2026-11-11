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
      {
        home.packages = lib.optional pkgs.stdenv.hostPlatform.isLinux pkgs.grimblast;
        programs.vicinae = {
          enable = true;
        }
        // lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
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
