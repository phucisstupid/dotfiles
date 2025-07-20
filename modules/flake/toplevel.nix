# Top-level flake glue to get our configuration working
{inputs, ...}: {
  imports = [
    inputs.nixos-unified.flakeModules.default
    inputs.nixos-unified.flakeModules.autoWire
  ];
  perSystem = {self', ...}: {
    # Enables 'nix run' to activate.
    packages.default = self'.packages.activate;
  };
}
