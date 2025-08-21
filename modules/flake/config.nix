# Top-level configuration for everything in this repo.
#
# Values are set in 'config.nix' in repo root.
{ lib, ... }:
let
  userSubmodule = lib.types.submodule {
    options = {
      username = lib.mkOption {
        type = lib.types.str;
      };
      name = lib.mkOption {
        type = lib.types.str;
      };
      email = lib.mkOption {
        type = lib.types.str;
      };
      namespace = lib.mkOption {
        type = lib.types.str;
      };
    };
  };
in
{
  imports = [ ../../config.nix ];
  options = {
    me = lib.mkOption {
      type = userSubmodule;
    };
  };
}
