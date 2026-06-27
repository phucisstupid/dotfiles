# main dendritic entry
{inputs, ...}: {
  imports = [
    (inputs.flake-file.flakeModules.dendritic or {})
    (inputs.den.flakeModules.dendritic or {})
  ];

  flake-file.inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    den.url = "github:denful/den";
    flake-file.url = "github:denful/flake-file";
  };
}
