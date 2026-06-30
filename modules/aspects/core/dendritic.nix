# Main dendritic entry
{inputs, lib, ...}: {
  flake-file.inputs = {
    flake-file.url = "github:denful/flake-file";
    den.url = "github:denful/den";
  };
  imports = [
    (inputs.flake-file.flakeModules.dendritic or {})
    (inputs.den.flakeModules.dendritic or {})
  ];
}
