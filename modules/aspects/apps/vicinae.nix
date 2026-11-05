{ inputs, ... }:
{
  flake-file.inputs.vicinae-extensions = {
    url = "github:vicinaehq/extensions";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.app.vicinae = {
    homeManager =
      { pkgs, ... }:
      let
        inherit (pkgs.stdenv.hostPlatform) system;
        extPkgs = inputs.vicinae-extensions.packages.${system};
        bluetooth =
          extPkgs.bluetooth or (inputs.vicinae-extensions.inputs.vicinae.lib.${system}.mkVicinaeExtension {
            pname = "vicinae-extension-bluetooth";
            version = "0";
            src = "${inputs.vicinae-extensions}/extensions/bluetooth";
            npmFlags = [
              "--legacy-peer-deps"
              "--ignore-scripts"
            ];
            postPatch = ''
              substituteInPlace tsconfig.json --replace "../../" "${inputs.vicinae-extensions}/"
            '';
          });
      in
      {
        programs.vicinae = {
          enable = true;
          systemd.enable = true;
          settings = {
            launcher_window = {
              rounding = 0;
            };
          };
          extensions = [
            bluetooth
            extPkgs.wifi-commander
            extPkgs.vscrot
          ];
        };
      };
  };
}
